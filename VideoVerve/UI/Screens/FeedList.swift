//
//  FeedList.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI

struct FeedList: View {
    
//    @EnvironmentObject var feedData: FeedsModel
    @State private var feeds: Loadable<LazyList<Feeds2>>
    @State private var routingState: Routing = .init()
    
    
    init(feeds: Loadable<LazyList<Feeds2>> = .notRequested) {
//        self.feedData = feedData
        self.feeds = feeds
    }
    
    var body: some View {
        NavigationView {
            self.content
        }
    }
    
    @ViewBuilder private var content: some View {
        switch feeds {
        case .notRequested:
            Text("TestText")
        case let .isLoading(last, _):
            Text("TestText")
        case let .loaded(feeds):
            Text("TestText")
        case let .failed(error):
            Text("TestText")
        }
    }
}

// MARK: - DISPLAYING CONTENT

extension FeedList {
    func loadedView(_ feeds: LazyList<Feeds2>, showLoading: Bool) -> some View {
        VStack {
            if showLoading {
                ActivityIndicatorView().padding()
            }
            
            List(feeds) { feed in
                FeedItem()
            }
            .id(feeds.count)
        }
    }
}

// MARK: - ROUTING

extension FeedList {
    struct Routing: Equatable {
        var feedDetails: Feeds2.Code?
    }
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList()
            .environmentObject(FeedsModel())
    }
}
