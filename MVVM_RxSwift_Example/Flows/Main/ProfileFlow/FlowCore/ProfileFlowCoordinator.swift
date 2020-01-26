//
//  ProfileFlowCoordinator.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/29/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

enum ProfileNavigationEvent: Event {
    
}

final class ProfileFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let container: Container
    
    private var rootViewController: ProfileViewController?
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container)
        
        super.init(parent: parent)
        
        ProfileFlowAssembly().assemble(container: self.container)
        addHandlers()
    }
    
    func addHandlers() {
        addHandler { [weak self] (event: ProfileNavigationEvent) in
            self?.handle(event)
        }
    }
    
    private func handle(_ event: ProfileNavigationEvent) {
        switch event {
            
        }
    }
    
    func createFlow() -> UIViewController {
        let controller: ProfileViewController = container.autoresolve(argument: self)
        controller.title = L10n.profileTabTitle
        rootViewController = controller
        
        return controller
    }
    
}
