//
//  AppState.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 29/02/24.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
}

extension AppState {
    struct UserData: Equatable {
        
    }
}


extension AppState {
    struct ViewRouting: Equatable {
        var feedsList = FeedList.Routing()
    }
}


extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
    lhs.routing == rhs.routing &&
    lhs.system == rhs.system
}


#if DEBUG
extension AppState {
    static var preview: AppState {
        var appState = AppState()
        appState.system.isActive = true
        return appState
    }
}
#endif
