//
//  SystemEventsHandler.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 28/02/24.
//

import UIKit

protocol SystemEventsHandler {
    func sceneDidBecomeActive()
    func sceneWillResignActive()
}

struct AppSystemEventsHandler: SystemEventsHandler {
    let container: DIContainer
    private var cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func sceneDidBecomeActive() {
        container.appState[\.system.isActive] = true
    }
    
    func sceneWillResignActive() {
        container.appState[\.system.isActive] = false
    }
}
