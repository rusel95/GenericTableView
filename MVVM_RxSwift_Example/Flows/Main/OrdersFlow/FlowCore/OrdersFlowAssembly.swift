//
//  OrdersFlowAssembly.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import RxCocoa

final class OrdersFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container
            .register(OrdersViewController.self) { (_, parent: EventNode) in
                let model = OrdrersModel(parent: parent)
                let viewController = StoryboardScene.Orders.ordersViewController.instantiate()
                viewController.viewModel = OrdersViewModel(model: model)
                
                return viewController
            }
            .inObjectScope(.transient)
        
    }
}
