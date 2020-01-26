//
//  AuthFlowCoordinator.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import Swinject

enum AuthFlowEvent: Event {
    
    case signedIn
    
}

final class AuthFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let container: Container
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container)
        
        super.init(parent: parent)
        
        AuthFlowAssembly().assemble(container: self.container)
        addHandlers()
    }
    
    func createFlow() -> UIViewController {
        let controller: AuthenticationViewController = container.autoresolve(argument: self)
        return controller
    }
    
    func addHandlers() {
        addHandler { [weak self] (event: AuthFlowEvent) in
            self?.handle(event)
        }
    }
    
    private func handle(_ event: AuthFlowEvent) {
        switch event {
        case .signedIn:
            break
        }
    }
    
}
