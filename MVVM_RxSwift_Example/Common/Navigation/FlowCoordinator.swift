//
//  FlowCoordinator.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit

protocol FlowCoordinator: class {
    
    var containerViewController: UIViewController? { get set }
    @discardableResult func createFlow() -> UIViewController
    
}

extension FlowCoordinator {
    
    var navigationController: UINavigationController? {
        if let navigationController = containerViewController as? UINavigationController {
            return navigationController
        } else {
            return containerViewController?.navigationController
        }
    }
    
}

extension FlowCoordinator {
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
