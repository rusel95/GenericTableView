//
//  MapFlowCoordinator.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

enum MapNavigationEvent: Event {
    
}

final class MapFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let container: Container
    
    private var rootViewController: MapViewController?
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container)
        
        super.init(parent: parent)
        
        MapFlowAssembly().assemble(container: self.container)
        addHandlers()
    }
    
    func addHandlers() {
        addHandler { [weak self] (event: MapNavigationEvent) in
            self?.handle(event)
        }
    }
    
    private func handle(_ event: MapNavigationEvent) {
        switch event {
            
        }
    }
    
    func createFlow() -> UIViewController {
        let controller: MapViewController = container.autoresolve(argument: self)
        controller.title = L10n.mapTabTitle
        rootViewController = controller
        
        return controller
    }
    
}
