//
//  RequestManager.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import AlamofireNetworkActivityIndicator

typealias JSONEncoding = Alamofire.JSONEncoding
typealias UnregisteredHandler = () -> Void

private let uploadingThreshold: UInt64 = 10 * 1000 * 1000
private let restorePath = "/users/exchange_token"

protocol AccessCredentialsProviding: class {
    
    var accessToken: String? { get set }
    var exchangeToken: String? { get set }
    func commitCredentialsUpdate(_ update: (AccessCredentialsProviding) -> Void)
    func invalidate()
    
}

protocol RequestRetrier: class {
    
    var inProgress: BehaviorRelay<Bool> { get set }
    func shouldRetry(error: Error, manager: RequestManager) -> Observable<Bool>
    
}

extension RequestRetrier {
    
    func shouldRetry(error: Error, manager: RequestManager) -> Observable<Bool> {
        if let error = error as? ExampleError,
            let afError = error.underlyingError as? AFError,
            afError.responseCode == 401
                && manager.credentialsProvider?.exchangeToken != nil {
            inProgress.accept(true)
            
            return manager.restoreSession()
                .do(onNext: { authorizationData in
                    manager.credentialsProvider?.commitCredentialsUpdate {
                        $0.accessToken = authorizationData.auth.accessToken
                        $0.exchangeToken = authorizationData.auth.exchangeToken
                    }
                    self.inProgress.accept(false)
                })
                .catchError({ _ -> Observable<CommonAuth> in
                    Observable.error(ExampleError.Network.from(error: error))
                })
                .map { _ in
                    return true
            }
        } else {
            return Observable.error(error)
        }
    }
    
}

class Retrier: RequestRetrier {
    var inProgress = BehaviorRelay<Bool>(value: false)
}

public final class RequestManager {
    
    var credentialsProvider: AccessCredentialsProviding!
    private let defaultPath: String
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        return SessionManager(configuration: configuration)
    }()
    
    fileprivate func headers(with tokenNeeded: Bool) -> [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers["Connection"] = "Keep-Alive"
        
        if tokenNeeded, let accessToken = credentialsProvider.accessToken, !accessToken.isEmpty {
            headers["Authorization"] = "Token token=" + accessToken
            debugPrint("Token token=" + accessToken)
        }
        
        return headers
    }
    
    var retrier = Retrier()
    var reachabilty: HostReachability
    let disposeBag = DisposeBag()
    
    public let isReachable = BehaviorRelay<Bool>(value: true)
    
    public init() {
        self.defaultPath = Environment.default.serverUrl
        self.reachabilty = HostReachability()
        self.reachabilty.statusEvent
            .map { status -> Bool in
                if case HostReachability.NetworkReachabilityStatus.reachable = status {
                    return true
                } else {
                    return false
                }
            }
            .bind(to: isReachable)
            .disposed(by: disposeBag)
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        NetworkActivityIndicatorManager.shared.startDelay = 0.1
        NetworkActivityIndicatorManager.shared.completionDelay = 0.3
    }
    
    // MARK: - Public Methods
    
    func executeRequest<T: ResponseHandler>(withURL url: URL,
                                            responseHandler: T) -> Observable<T.Value> {
        let request = _executeRequest(withURL: url)
        
        return request.flatMapLatest { response -> Observable<T.Value> in
            if let data = response.data {
                return responseHandler.handleResponse(data)
            } else {
                return Observable.error(ExampleError.serializationFault)
            }
        }
    }
    
    func executeRequest<T: ResponseHandler>(withPath path: String,
                                            parameters: [String: Any]? = nil,
                                            method: HTTPMethod,
                                            tokenNeeded: Bool = true,
                                            encoding: ParameterEncoding = URLEncoding.default,
                                            responseHandler: T) -> Observable<T.Value> {
        
        let request = _executeRequest(withPath: path,
                                      parameters: parameters,
                                      method: method,
                                      tokenNeeded: tokenNeeded,
                                      encoding: encoding)
        
        return request
            .catchError { error -> Observable<DataResponse<Any>> in
                let requestExecuterObserver = self._executeRequest(
                    withPath: path,
                    parameters: parameters,
                    method: method,
                    encoding: encoding
                )
                
                if let fagError = error as? ExampleError, let metaData = fagError.metadata {
                    switch metaData.metaCode?.rawValue {
                    case NetworkError.blocked_user.rawValue:
                        self.credentialsProvider?.invalidate()
                    default:
                        break
                    }
                }
                
                if self.retrier.inProgress.value {
                    if path == restorePath {
                        self.credentialsProvider?.invalidate()
                        self.retrier.inProgress.accept(false)
                        return Observable.error(ExampleError.Network.from(error: error))
                    } else {
                        return self.retrier.inProgress.asObservable()
                            .filter { $0 == false }
                            .flatMap { _ in requestExecuterObserver }
                    }
                } else {
                    let retrySignal = self.retrier.shouldRetry(error: error, manager: self)
                    return retrySignal.flatMapLatest { shouldRetry -> Observable<DataResponse<Any>> in
                        if shouldRetry {
                            return requestExecuterObserver
                        } else {
                            return Observable.error(ExampleError.Network.from(error: error))
                        }
                    }
                }
            }.flatMapLatest { response -> Observable<T.Value> in
                if let data = response.data {
                    return responseHandler.handleResponse(data)
                } else {
                    return Observable.error(ExampleError.serializationFault)
                }
            }
    }
    
    private func _executeRequest(withURL url: URL) -> Observable<DataResponse<Any>> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create() }
            
            let request = self.sessionManager
                .request(url)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        observer.onNext(response)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(ExampleError.Network.from(error: error, metadata: response.data))
                    }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    fileprivate func _executeRequest(withPath path: String,
                                     parameters: [String: Any]? = nil,
                                     method: HTTPMethod,
                                     tokenNeeded: Bool = true,
                                     encoding: ParameterEncoding = URLEncoding.default
        ) -> Observable<DataResponse<Any>> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create() }
            
            let request = self.sessionManager.requestWithoutCache(
                self.defaultPath + path,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: self.headers(with: tokenNeeded))
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        observer.onNext(response)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        let fagError = ExampleError.Network.from(error: error, metadata: response.data)
                        observer.onError(fagError)
                    }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func restoreSession() -> Observable<CommonAuth> {
        let params = ["exchange_token": credentialsProvider?.exchangeToken ?? ""]
        return executeRequest(withPath: restorePath,
                              parameters: params,
                              method: .post,
                              tokenNeeded: false,
                              encoding: JSONEncoding.default,
                              responseHandler: AuthorizationResponseHandler())
    }
    
}
