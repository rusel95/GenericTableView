//
//  ProfileResponseHandler.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

final class ProfileResponseHandler: ResponseHandler {
    
    func handleResponse(_ response: Data) -> Observable<ProfileExample> {
        guard let profile = try? JSONDecoder().decode(ProfileExample.self, from: response) else {
            return Observable.error(ExampleError.serializationFault)
        }
        return Observable.just(profile)
    }
    
}
