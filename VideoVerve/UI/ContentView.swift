//
//  ContentView.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI

struct ContentView: View {
    
    private let container: DIContainer
    private let isRunningTests: Bool
    @State private var item: TabItem = .feed
    
    enum TabItem {
        case feed
        case profile
    }
    
    init(container: DIContainer, isRunningTests: Bool = ProcessInfo.processInfo.isRunningTests) {
        self.container = container
        self.isRunningTests = isRunningTests
    }
            
    var body: some View {
        TabView(selection: $item) {
            FeedList()
                .tabItem {
                    Label("Feeds", systemImage: "video.circle.fill")
                }
                .tag(TabItem.feed)
                .inject(container)
            
            ProfileSummary()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
                .tag(TabItem.profile)
                .inject(container)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
