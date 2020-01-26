//
//  CompletionResponseHandler.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

final class CompletionResponseHandler: ResponseHandler {
    
    func handleResponse(_ response: Data) -> Observable<Void> {
        return Observable.just(())
    }
    
}
