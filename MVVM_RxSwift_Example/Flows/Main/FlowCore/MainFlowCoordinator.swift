//
//  MainFlowCoordinator.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import Swinject

enum MainFlowEvent: Event {
    case switchToList
    case switchToMap
    case switchToOrders
    case switchToProfile
}

enum Tab: Int {
    case list
    case map
    case orders
    case profile
}

final class MainFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    
    private var tabBarController: MainContainerController!
    
    private let container: Container
    
    private lazy var exploreController: UIViewController = {
        let flowCoordinator: ExploreFlowCoordinator = container.autoresolve(argument: self)
        let exploreViewController = flowCoordinator.createFlow()
        let containerViewController = UINavigationController(rootViewController: exploreViewController)
        
        containerViewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        containerViewController.navigationBar.shadowImage = UIImage()
        containerViewController.navigationBar.isTranslucent = true
        containerViewController.view.backgroundColor = .clear
        
        flowCoordinator.containerViewController = containerViewController
        
        let item = UITabBarItem(
            title: L10n.exploreTabTitle,
            image: Asset.tabIconExplore.image.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.tabIconExplore.image.withRenderingMode(.alwaysOriginal)
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.exampleTabBarFontUnselectedColor.color],
            for: .normal
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.exampleTabBarFontSelectedColor.color],
            for: .selected
        )
        exploreViewController.tabBarItem = item
        
        return containerViewController
    }()
    
    private lazy var mapController: UIViewController = {
        let flowCoordinator: MapFlowCoordinator = container.autoresolve(argument: self)
        
        let viewController = flowCoordinator.createFlow()
        let containerViewController = UINavigationController(rootViewController: viewController)
        
        viewController.navigationController?.isNavigationBarHidden = true
        containerViewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        containerViewController.navigationBar.shadowImage = UIImage()
        containerViewController.navigationBar.isTranslucent = true
        containerViewController.view.backgroundColor = .clear
        
        flowCoordinator.containerViewController = containerViewController
        
        let item = UITabBarItem(
            title: L10n.mapTabTitle,
            image: Asset.tabIconMap.image.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.tabIconMap.image.withRenderingMode(.alwaysOriginal)
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.exampleTabBarFontUnselectedColor.color],
            for: .normal
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.exampleTabBarFontSelectedColor.color],
            for: .selected
        )
        viewController.tabBarItem = item
        
        return containerViewController
    }()
    
    private lazy var ordersController: UIViewController = {
        let flowCoordinator: OrdersFlowCoordinator = container.autoresolve(argument: self)
        
        let viewController = flowCoordinator.createFlow()
        let containerViewController = UINavigationController(rootViewController: viewController)
        
        viewController.navigationController?.isNavigationBarHidden = true
        containerViewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        containerViewController.navigationBar.shadowImage = UIImage()
        containerViewController.navigationBar.isTranslucent = true
        containerViewController.view.backgroundColor = .clear
        
        flowCoordinator.containerViewController = containerViewController
        
        let item = UITabBarItem(
            title: L10n.ordersTabTitle,
            image: Asset.tabIconCart.image.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.tabIconCart.image.withRenderingMode(.alwaysOriginal)
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.exampleTabBarFontUnselectedColor.color],
            for: .normal
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.exampleTabBarFontSelectedColor.color],
            for: .selected
        )
        viewController.tabBarItem = item
        
        return containerViewController
    }()
    
    private lazy var profileController: UIViewController = {
        let flowCoordinator: ProfileFlowCoordinator = container.autoresolve(argument: self)
        let viewController = flowCoordinator.createFlow()
        let containerViewController = UINavigationController(rootViewController: viewController)
        flowCoordinator.containerViewController = containerViewController
        
        let item = UITabBarItem(
            title: L10n.profileTabTitle,
            image: Asset.tabIconProfile.image.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.tabIconProfile.image.withRenderingMode(.alwaysOriginal)
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.exampleTabBarFontUnselectedColor.color],
            for: .normal
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.exampleTabBarFontSelectedColor.color],
            for: .selected
        )
        viewController.tabBarItem = item
        return containerViewController
    }()
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container) {
            MainFlowAssembly().assemble(container: $0)
        }
        super.init(parent: parent)
        
        addHandlers()
    }
    
    func createFlow() -> UIViewController {
        let tabBarController: MainContainerController = container.autoresolve(argument: self)
        self.tabBarController = tabBarController
        assembleActualTabs()
        containerViewController = self.tabBarController
        self.tabBarController.selectedIndex = Tab.map.rawValue
        return tabBarController
    }
    
    // MARK: - Private Methods
    
    private func assembleActualTabs() {
        tabBarController.viewControllers = [
            exploreController,
            mapController,
            ordersController,
            profileController
        ]
    }
    
    private func addHandlers() {
        addHandler { [weak self] (event: MainFlowEvent) in
            switch event {
            case .switchToList:
                self?.tabBarController.selectedIndex = Tab.list.rawValue
            case .switchToMap:
                self?.tabBarController.selectedIndex = Tab.map.rawValue
            case .switchToOrders:
                self?.tabBarController.selectedIndex = Tab.orders.rawValue
            case .switchToProfile:
                self?.tabBarController.selectedIndex = Tab.profile.rawValue
            }
        }
    }
    
}

// MARK: - authorization flow
private extension MainFlowCoordinator {
    func presentAuthenticationModule() {
        let flowCoordinator: AuthFlowCoordinator = AuthFlowCoordinator(parent: self, container: self.container)
        let containerViewController = UINavigationController(rootViewController: flowCoordinator.createFlow())
        flowCoordinator.containerViewController = containerViewController
        addHandler { [weak self] (event: AuthFlowEvent) in
            self?.handle(event)
        }
        tabBarController.present(containerViewController, animated: true)
    }
    
    func hideAuthenticationModule() {
        tabBarController.presentedViewController?.dismiss(animated: true)
    }
    
    func handle(_ event: AuthFlowEvent) {
        switch event {
        case .signedIn:
            hideAuthenticationModule()
        }
    }
}
