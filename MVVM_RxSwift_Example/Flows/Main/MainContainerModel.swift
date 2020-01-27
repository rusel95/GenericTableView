//
//  MainContainerModel.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/26/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import RxSwift
import RxCocoa

final class MainContainerModel: EventNode, HasDisposeBag {
    
    // MARK: - Init.
    
    let mainTabBarLoaded = PublishSubject<Void>()
    let switchToTabAction = PublishSubject<Tab>()
    
    // TODO: add later
//    private let userSession: UserSessionType
//    private let userService: UserService
    
    override init(parent: EventNode) {//, userSession: UserSessionType, userService: UserService) {
//        self.userSession = userSession
//        self.userService = userService
        super.init(parent: parent)
        
        initializeBindings()
    }
    
    // MARK: - Private Methods
    
    private func initializeBindings() {
 
//        mainTabBarLoaded
//            .subscribe(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                
//            }).disposed(by: disposeBag)
        
        switchToTabAction
            .subscribe(onNext: { [weak self] tab in
                guard let self = self else { return }
                switch tab {
                case .explore:
                    self.raise(event: MainFlowEvent.switchToExplore)
                case .map:
                    self.raise(event: MainFlowEvent.switchToMap)
                case .orders:
                    self.raise(event: MainFlowEvent.switchToOrders)
                case .profile:
                    self.raise(event: MainFlowEvent.switchToProfile)
                }
            }).disposed(by: disposeBag)
    }
    
}
