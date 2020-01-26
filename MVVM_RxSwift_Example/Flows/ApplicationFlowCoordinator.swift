//
//  ApplicationFlowCoordinator.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import Swinject

enum ApplicationEvent: Event {
    case applicationDidEnterBackground
    case applicationWillEnterForeground
    case onboardingFlowShown
}

final class ApplicationFlowCoordinator: EventNode {
    
    public let container = Container()
    
    private let window: UIWindow
    private weak var application: UIApplication?

    // MARK: init
    
    init(window: UIWindow) {
        self.window = window
        
        super.init()
    }
    
    func execute() {
        presentMainModule()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.raise(event: ApplicationEvent.applicationDidEnterBackground)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.raise(event: ApplicationEvent.applicationWillEnterForeground)
    }
    
    // MARK: Modules presentation
    
    fileprivate func presentMainModule() {
        let flowCoordinator = MainFlowCoordinator(parent: self, container: container)
        let containerViewController = flowCoordinator.createFlow()
        flowCoordinator.containerViewController = containerViewController
        setWindowRootViewController(with: containerViewController)
    }
    
    // MARK: Helpers
    
    private func setWindowRootViewController(with viewController: UIViewController) {
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
    
}

private extension ApplicationFlowCoordinator {
    func addHandlers() {
        addHandler { [weak self] (event: ApplicationEvent) in
            self?.handle(event)
        }
    }
    
    func handle(_ event: ApplicationEvent) {
        switch event {
        case .onboardingFlowShown:
            presentMainModule()
        default:
            break
        }
    }
}
