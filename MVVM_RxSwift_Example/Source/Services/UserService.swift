//
//  UserService.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

final class UserService {
    
    private let requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func authorize(authToken: String) -> Observable<CommonAuth> {
        let handler = AuthorizationResponseHandler()
        let params: [String: Any] = ["oauth_token": authToken]
        return requestManager.executeRequest(
            withPath: "/users/session",
            parameters: params,
            method: .post,
            encoding: JSONEncoding.default,
            responseHandler: handler
            )
            .catchError {
                return Observable.error(
                    ExampleError.Network.from(error: $0, context: ExampleErrorContext.authorization)
                )
        }
    }
    
    func deleteUserSession() -> Observable<Void> {
        let handler = CompletionResponseHandler()
        return requestManager.executeRequest(
            withPath: "/users/session",
            method: .delete,
            encoding: JSONEncoding.default,
            responseHandler: handler
            )
            .catchError {
                return Observable.error(
                    ExampleError.Network.from(error: $0, context: ExampleErrorContext.authorization)
                )
        }
    }

    func updateProfile(identifier: Int, with username: String) -> Observable<ProfileExample> {
        let handler = ProfileResponseHandler()
        
        var params = [String: String]()
        params[ProfileExample.CodingKeys.username.rawValue] = username
        
        return requestManager.executeRequest(withPath: "/profile",
                                             parameters: params,
                                             method: .put,
                                             encoding: JSONEncoding.default,
                                             responseHandler: handler)
            .flatMap { profile -> Observable<ProfileExample> in
                let realm = RealmService.shared.realm
                try? realm.write {
                    realm.add(profile, update: .modified)
                }
                return Observable.just(profile)
            }
            .catchError {
                return Observable.error(ExampleError.Network.from(error: $0, context: ExampleErrorContext.profile))
            }
    }
    
    func getProfile() -> Observable<ProfileExample> {
        let handler = ProfileResponseHandler()
        
        return requestManager.executeRequest(
            withPath: "/profile",
            method: .get,
            responseHandler: handler
            )
            .flatMap { profile -> Observable<ProfileExample> in
                let realm = RealmService.shared.realm
                try? realm.write {
                    realm.add(profile, update: .modified)
                }
                return Observable.just(profile)
            }
            .catchError {
                return Observable.error(ExampleError.Network.from(error: $0, context: ExampleErrorContext.profile))
            }
    }
    
}
