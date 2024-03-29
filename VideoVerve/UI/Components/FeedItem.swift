//
//  FeedItem.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI
import Combine

struct FeedItem: View {
    
    private let feedData: Feed
    @State private(set) var feed: Loadable<Feed>
    @State private var routingState: Routing = .init()
    @Environment(\.injected) private var injected: DIContainer
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.feedItem)
    }
    
    init(_ feedData: Feed, feed: Loadable<Feed> = .notRequested) {
        self.feedData = feedData
        self._feed = .init(initialValue: feed)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CircleImage(image: Image("turtlerock"))
                    .scaleEffect(1.0 / 3.0)
                Text("\(feedData.username)")
                    .font(.callout)
                    .bold()
                Spacer()
                Text("\(feedData.likes) Likes")
                    .font(.footnote)
                    .fontWeight(.light)
            }
            CustomVideoPlayer(feed: feedData)
//            Divider()
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        .border(.ultraThinMaterial)
    }
    
    @ViewBuilder private var content: some View {
        switch feed {
        case .notRequested:
            notRequestedView()
        case .isLoading(_, _):
            loadingView()
        case .loaded(let feed):
            loadedView(feed, isLoading: false)
        case.failed(_):
            failedView()
        }
    }
}

extension FeedItem {
    struct Routing: Equatable {
    }
}

private extension FeedItem {
    func loadedView(_ feed: Feed, isLoading: Bool) -> some View {
        ZStack {
            VStack(alignment: .center) {
                HStack {
                    CircleImage(image: Image("turtlerock"))
                        .scaleEffect(1.0 / 3.0)
                    
                    Text("\(feed.username)")
                        .font(.callout)
                        .bold()
                    Spacer()
                    
                    Text("\(feed.likes) Likes")
                }
                
                CustomVideoPlayer(feed: feed)
                    .frame(width: 320, height: 180, alignment: .center)
                
                Divider()
            }
            Rectangle()
        }
    }
}

private extension FeedItem {
    
    func notRequestedView() -> some View {
        Text("").font(.caption)
    }
    
    func loadingView() -> some View {
        Text("").font(.caption)
    }
    
    func failedView() -> some View {
        Text("").font(.caption)
    }
}

struct FeedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeedItem(Feed.mockedData[0], feed: .notRequested)
    }
}
