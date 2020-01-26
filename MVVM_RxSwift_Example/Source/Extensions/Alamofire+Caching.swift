//
//  Alamofire+Caching.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.SessionManager {
    
    @discardableResult
    open func requestWithoutCache(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> DataRequest {

        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            fatalError("wrong_request")
        }
    }
    
}
