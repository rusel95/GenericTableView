//
//  AuthorizationResponseHandler.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift

final class AuthorizationResponseHandler: ResponseHandler {
    
    func handleResponse(_ response: Data) -> Observable<CommonAuth> {
        guard let commonAuth = try? JSONDecoder().decode(CommonAuth.self, from: response) else {
            return Observable.error(ExampleError.serializationFault)
        }
        
        return Observable.just(commonAuth)
    }
    
}
