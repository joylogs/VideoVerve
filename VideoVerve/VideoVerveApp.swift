//
//  VideoVerveApp.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI

@main
struct VideoVerveApp: App {
    
    private var feedsData = FeedsModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(feedsData)
        }
    }
}
