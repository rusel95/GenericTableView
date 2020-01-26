//
//  Error.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Protocols

protocol ErrorCodesList {
    
    static func allCodes() -> [ErrorCode]
    
}

protocol ErrorContext {
    
    var rawValue: String { get }
    
}

public protocol ErrorCode {
    
    static var domain: String { get }
    var rawValue: String { get }
    
}

protocol ErrorArea {
    
    static func from(error: Error, context: ErrorContext?, metadata: Data?) -> ExampleError
    
}

// MARK: - Enums

enum ExampleErrorContext: String, ErrorContext {
    
    case connections = "connections"
    case gameZone = "gameZone"
    case createMode = "createMode"
    case authorization = "authorization"
    case push = "push"
    case notifications = "notifications"
    case requests = "requests"
    case reports = "reports"
    case profile = "profile"
    case likes = "likes"
    case creation = "creation"
    case oneOffEvent = "oneOffEvent"
    case serialization = "serialization"
    case none = ""
    case share = "share"
    
}

public enum NetworkError: String, ErrorCode {
    
    static public var domain = "network_error"
    
    case generic = "generic"
    case badResponse = "bad_response"
    case badToken = "bad_token"
    case invalidURL = "invalid_url"
    case urlNotFound = "url_not_found"
    case noInternetConnection = "no_internet_connection"
    case serializationFailed = "serialization_failed"
    case badParameters = "bad_parameters"
    case blocked_user = "access_denied"
    case noUser = "no_user"
    
}

enum StringValidationError: String, ErrorCode {
    
    static var domain = { return "com.fiveandgo.validation" }()
    
    case invalidEmail = "invalid_email"
    case invalidPassword = "invalid_password"
    
}

// MARK: - ExampleError

public struct ErrorMetadata {
    
    let metaCode: ErrorCode?
    let thematicStacks: [ErrorThematicStack]
    
    static func create(data: Data?) -> ErrorMetadata? {
        if let dictionary = data?.JSONRepresentation() {
            if let dataDictionary = dictionary["data"] as? [String: Any],
                let errorDictionary = dataDictionary["error"] as? [String: Any],
                let metaDictionary = dataDictionary["meta"] as? [String: Any] {
                let metaCode = NetworkError(rawValue: errorDictionary["code"] as? String ?? "")
                let stacks: [ErrorThematicStack] = metaDictionary.keys.compactMap { key in
                    if let dictionary = metaDictionary[key] as? [String: Any] {
                        return ErrorThematicStack.create(title: key, dictionary: dictionary)
                    }
                    
                    if let value = metaDictionary[key] as? String {
                        return ErrorThematicStack.create(title: key, value: value)
                    }
                    return nil
                }
                return ErrorMetadata(metaCode: metaCode, thematicStacks: stacks)
            }
            return nil
        }
        return nil
    }
    
    public func fullErrorDescription() -> String {
        var result = ""
        thematicStacks.forEach {
            $0.localStack?.forEach {
                result.append(errorDescription(for: $0))
                result.append("\r\n")
            }
        }
        return result
    }
    
    public func thematicStack() -> [(String, String)] {
        var result = [(String, String)]()
        thematicStacks.forEach {
            $0.localStack?.forEach {
                result.append(($0.title, errorDescription(for: $0)))
            }
        }
        return result
    }
    
    private func errorDescription(for localStack: ErrorLocalStack) -> String {
        var result = ""
        if let reasons = localStack.reasons {
            result.append("\(localStack.title): ")
            result.append(reasons.compactMap { $0.description }.joined(separator: ", "))
        }
        return result
    }
    
    func firstErrorDescription() -> String? {
        if let stack = thematicStacks[0].localStack?[0] {
            return errorDescription(for: stack)
        }
        return ""
    }
    
}

public struct ErrorThematicStack {
    
    let title: String
    public let localStack: [ErrorLocalStack]?
    
    static func create(title: String, dictionary: [String: Any]) -> ErrorThematicStack? {
        let localStacks: [ErrorLocalStack]? = dictionary.keys.compactMap { key in
            if let stack = dictionary[key] as? [[String: Any]] {
                return ErrorLocalStack.create(title: key, reasons: stack)
            } else if let stack = dictionary[key] as? [String] {
                return ErrorLocalStack.create(title: key, reasons: stack)
            }
            
            return nil
        }
        
        return ErrorThematicStack(title: title, localStack: localStacks)
    }
    
    static func create(title: String, value: String) -> ErrorThematicStack? {
        if let localStack = ErrorLocalStack.create(title: title, reasons: [value]) {
            
            return ErrorThematicStack(title: title, localStack: [localStack])
        }
        return nil
    }
    
}

public struct ErrorLocalStack {
    
    public let title: String
    public let reasons: [ErrorReason]?
    
    static func create(title: String, reasons: [String]) -> ErrorLocalStack? {
        let reasons: [ErrorReason] = reasons.compactMap {
            ErrorReason(code: title, description: $0)
        }
        return ErrorLocalStack(title: title,
                               reasons: reasons
        )
    }
    
    static func create(title: String, reasons: [[String: Any]]) -> ErrorLocalStack? {
        let reasons: [ErrorReason] = reasons.compactMap {
            ErrorReason.create(dictionary: $0)
        }
        
        return ErrorLocalStack(title: title, reasons: reasons)
    }
    
}

public struct ErrorReason {
    
    public let code: String
    public let description: String
    
    static func create(dictionary: [String: Any]) -> ErrorReason? {
        guard let code = dictionary["code"] as? String, let description = dictionary["description"] as? String else {
            return nil
        }
        return ErrorReason(
            code: code,
            description: description
        )
    }
    
}

public struct ExampleError: Error {
    
    let domain: String
    public let code: ErrorCode
    var context: ErrorContext?
    public let underlyingError: Error?
    public var metadata: ErrorMetadata?
    
    init(code: ErrorCode,
         context: ErrorContext? = nil,
         underlyingError: Error? = nil,
         metadata: Data? = nil) {
        self.domain = type(of: code).domain
        self.code = code
        self.context = context
        self.underlyingError = underlyingError
        self.metadata = ErrorMetadata.create(data: metadata)
    }
    
    var localizedDescription: String {
        if let description = metadata?.fullErrorDescription() {
            return description
        }
        if let description = underlyingError?.localizedDescription {
            return description
        }
        return NSLocalizedString(descriptionString(), comment: "")
    }
    
    func fullDescription() -> String {
        return descriptionString() + ": " + localizedDescription
    }
    
    private func descriptionString() -> String {
        var descriptionString = "\(domain).\(code.rawValue)"
        
        if let context = context {
            descriptionString += ".\(context.rawValue)"
        }
        
        return descriptionString
    }
}

// MARK: - Areas

extension ExampleError {
    struct General: ErrorArea {
        
        static func from(error: Error, context: ErrorContext? = nil, metadata: Data? = nil) -> ExampleError {
            return ExampleError.unknown(context: context)
        }
        
    }
    
    struct Network: ErrorArea {
        
        static func from(error: Error, context: ErrorContext? = nil, metadata: Data? = nil) -> ExampleError {
            if let afError = error as? AFError {
                return self.from(afError: afError, context: context, metadata: metadata)
            } else if var error = error as? ExampleError, error.context == nil, let context = context {
                error.context = context
                
                return error
            } else {
                return self.from(nsError: error, context: context)
            }
        }
        
        static func from(
            afError error: AFError,
            context: ErrorContext? = nil,
            metadata: Data? = nil
            ) -> ExampleError {
            var code: ErrorCode
            var internalContext = context
            
            switch error {
            case .responseValidationFailed(let reason):
                switch reason {
                case .unacceptableStatusCode(let afCode):
                    switch afCode {
                    case 404:
                        code = NetworkError.urlNotFound
                        internalContext = nil
                    case 401:
                        code = NetworkError.badToken
                        internalContext = nil
                    default:
                        code = NetworkError.generic
                    }
                default:
                    code = NetworkError.generic
                }
            case .invalidURL:
                code = NetworkError.invalidURL
            case .responseSerializationFailed:
                code = NetworkError.invalidURL
            default:
                code = NetworkError.generic
            }
            
            return ExampleError(code: code, context: internalContext, underlyingError: error, metadata: metadata)
        }
        
        fileprivate static func from(nsError error: Error, context: ErrorContext? = nil) -> ExampleError {
            var code: ErrorCode
            var internalContext = context
            
            switch error._code {
            case -1009:
                code = NetworkError.noInternetConnection
                internalContext = nil
            default:
                code = NetworkError.generic
            }
            
            return ExampleError(code: code, context: internalContext, underlyingError: error)
        }
    }
}

// MARK: - Factory

extension ExampleError {
    static func from(_ error: Error, context: ErrorContext? = nil, metadata: Data? = nil) -> ExampleError {
        let area = ExampleError.area(of: error)
        
        return area.from(error: error, context: context, metadata: metadata)
    }
    
    static func unknown(context: ErrorContext? = nil) -> ExampleError {
        let code = NetworkError.generic
        
        return ExampleError(code: code, context: context)
    }
    
    static var serializationFault: ExampleError {
        return ExampleError(code: NetworkError.serializationFailed, context: ExampleErrorContext.serialization)
    }
    
    static var badParameters: ExampleError {
        return ExampleError(code: NetworkError.badParameters, context: ExampleErrorContext.requests)
    }
    
    static var noFireBaseUser: ExampleError {
        return ExampleError(code: NetworkError.noUser, context: ExampleErrorContext.profile)
    }
    
    fileprivate static func area(of error: Error) -> ErrorArea.Type {
        if error is AFError {
            return ExampleError.Network.self
        } else if error._domain == NSURLErrorDomain {
            return ExampleError.Network.self
        } else {
            return ExampleError.General.self
        }
    }
}

// MARK: - Required
extension ExampleError: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(code.rawValue)
        hasher.combine(domain)
    }
}

public func == (lhs: ExampleError, rhs: ExampleError) -> Bool {
    return lhs.code == rhs.code
}

func == (lhs: ErrorCode, rhs: ErrorCode) -> Bool {
    return lhs.rawValue == rhs.rawValue && type(of: lhs).domain == type(of: rhs).domain
}
