//
//  AppDelegate.swift
//  TVShows
//
//  Created by Filip Gulan on 11/07/2018.
//  Copyright © 2018 Filip Gulan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initializeInitializers()
        window = createAndSetupWindow()
        
        return true
    }
}

// MARK: - Private methods -

// MARK: - Initializers

private extension AppDelegate {
    
    func initializeInitializers() {
        let initializers: [Initializable] = [
            LoggingInitializer(),
            AlamofireInitializer(),
            LoggieInitializer()
        ]
        
        initializers.forEach { $0.initialize() }
    }
}

// MARK: - UI Setup

private extension AppDelegate {
    
    func createAndSetupWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = ShowsNavigationController()
        
        navigationController.setRootWireframe(LoginWireframe())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return window
    }
}
