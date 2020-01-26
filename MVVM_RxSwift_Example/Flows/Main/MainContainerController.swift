//
//  MainContainerController.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/26/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit

final class MainContainerController: UITabBarController {
    
    // MARK: - Properties
    
    var viewModel: MainContainerViewModel!
    
    override var viewControllers: [UIViewController]? {
        didSet {
            initializeBindings()
            viewModel.tabBarLoaded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        addShadow()
    }
    
    private func initializeBindings() {
        
    }
    
    private func addShadow() {
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
        tabBar.layer.shadowRadius = 5
        tabBar.layer.shadowOpacity = 0.1
    }
    
}

extension MainContainerController: UITabBarControllerDelegate {
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
        ) -> Bool {
        guard let viewControllers = self.viewControllers,
            !viewControllers.isEmpty,
            let firstIndex = viewControllers.firstIndex(of: viewController),
            let tab = Tab(rawValue: firstIndex) else { return false }
        
        viewModel.switchToTabAction.onNext(tab)
        
        return false
    }
}
