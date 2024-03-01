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
    
    init(container: DIContainer, isRunningTests: Bool = ProcessInfo.processInfo.isRunningTests) {
        self.container = container
        self.isRunningTests = isRunningTests
    }
        
    var body: some View {
        FeedList()
            .inject(container)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: .preview)
    }
}
