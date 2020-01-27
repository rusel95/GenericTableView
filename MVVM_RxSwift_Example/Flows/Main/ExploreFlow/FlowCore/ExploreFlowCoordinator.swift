//
//  ListFlowCoordinator.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/29/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

enum ExploreNavigationEvent: Event {
    case selectObjectFrom(items: [CellConfigurator])
}

final class ExploreFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let container: Container
    
    private var rootViewController: ExploreViewController?
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container)
        
        super.init(parent: parent)
        
        ExploreFlowAssembly().assemble(container: self.container)
        addHandlers()
    }
    
    func addHandlers() {
        addHandler { [weak self] (event: ExploreNavigationEvent) in
            switch event {
            case .selectObjectFrom(let items):
                let genericVC: GenericPickerViewController = ControllerFactory.createViewController()
                self?.rootViewController?.navigationController?.present(genericVC, animated: true)
            }
        }
    }

    func createFlow() -> UIViewController {
        let controller: ExploreViewController = container.autoresolve(argument: self)
        controller.title = L10n.exploreTabTitle
        rootViewController = controller
        
        return controller
    }
    
}
