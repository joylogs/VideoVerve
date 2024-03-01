//
//  AppDelegate.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 28/02/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var systemEventsHandler: SystemEventsHandler? = {
        self.systemEventsHandler(UIApplication.shared)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    private func systemEventsHandler(_ application: UIApplication) -> SystemEventsHandler? {
        return sceneDelegate(application)?.systemEventsHandler
    }
    
    func sceneDelegate(_ application: UIApplication) -> SceneDelegate? {
        return application.windows
            .compactMap({ $0.windowScene?.delegate as? SceneDelegate })
            .first
    }
}
