//
//  AuthenticationModel.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import RxSwift
import RxRealm
import RxCocoa

final class AuthenticationModel: EventNode, HasDisposeBag {
    
    // MARK: - Properties.
    let requestStateObservable = PublishSubject<RequestState>()
   
    //TODO: - implement userService and userSession later
    //private let userService: UserService
    
    // MARK: - Init.
    
    init(_ parent: EventNode) {
        super.init(parent: parent)
        
        initializeBindings()
    }
    
    // MARK: - Private Method.
    
    private func initializeBindings() {
        
    }
    
}
