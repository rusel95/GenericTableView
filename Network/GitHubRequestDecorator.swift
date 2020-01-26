//
//  GitHubRequestDecorator.swift
//  ArchitectureGuideTemplate
//
//  Created by Serhii Butenko on 26/10/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import APIClient

final class GitHubRequestDecorator: PluginType {
 
    // MARK: - Init
    
    private let tokenProvider: () -> String
    
    init(tokenProvider: @escaping () -> String) {
        self.tokenProvider = tokenProvider
    }
    
    convenience init(gitHubAuthService: GitHubAuthService) {
        self.init { () -> String in
            return gitHubAuthService.credentials.oauthToken
        }
    }
    
    // MARK: - PluginType
    
    func prepare(_ request: APIRequest) -> APIRequest {
        guard (request as? DecoratableRequest)?.authRequired == true else {
            return request
        }
      
        return TokenizedAPIRequest(request: request, token: tokenProvider())
    }
}

private struct TokenizedAPIRequest: APIRequest {
    
    var path: String
    var parameters: [String: Any]?
    var method: APIRequestMethod
    var headers: [String: String]?
    var multipartFormData: ((MultipartFormDataType) -> Void)?
    
    private let tokenKey = "access_token"
    
    init(request: APIRequest, token: String) {
        self.path = request.path
        self.parameters = request.parameters
        self.method = request.method
        self.multipartFormData = request.multipartFormData
        if let requestParameters = request.parameters {
            var decoratedParameters = requestParameters
            decoratedParameters[tokenKey] = token
            self.parameters = decoratedParameters
        } else {
            self.parameters = [tokenKey: token]
        }
    }
}
