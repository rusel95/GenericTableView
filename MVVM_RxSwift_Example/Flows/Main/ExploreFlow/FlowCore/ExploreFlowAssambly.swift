//
//  ListFlowAssambly.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/29/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import RxCocoa

final class ExploreFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container
            .register(ExploreViewController.self) { (_, parent: EventNode) in
                let model = ExploreModel(parent: parent)
                let viewController = StoryboardScene.Explore.exploreViewContoller.instantiate()
                viewController.viewModel = ExploreViewModel(model: model)
                
                return viewController
            }
            .inObjectScope(.transient)
        
    }
}
