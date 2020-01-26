//
//  AppDelegate.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let container = Container()
    
    var window: UIWindow?
    private var applicationFlowCoordinator: ApplicationFlowCoordinator!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        NotificationsService.shared.didFinishLaunching(application: application, launchOptions: launchOptions)
        applicationFlowCoordinator = ApplicationFlowCoordinator(window: window!)
        applicationFlowCoordinator.execute()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        applicationFlowCoordinator.applicationDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        applicationFlowCoordinator.applicationWillEnterForeground(application)
    }
    
}
