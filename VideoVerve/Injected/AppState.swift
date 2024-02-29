//
//  AppState.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 29/02/24.
//

import Foundation


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
        
    }
}


extension AppState {
    
    struct System: Equatable {
        
    }
}
