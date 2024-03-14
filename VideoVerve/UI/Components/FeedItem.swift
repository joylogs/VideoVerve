//
//  FeedItem.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI
import Combine

struct FeedItem: View {
    
    let feed: Feed
    
    @Environment(\.injected) private var injected: DIContainer
    
    private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        routingState.dispatched(to: injected.appState, \.routing.feedItem)
    }
    
    var body: some View {
        
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
    }
}

extension FeedItem {
    struct Routing: Equatable {
        
    }
}

struct FeedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeedItem(feed: Feed.mockedData[0])
            .previewLayout(.fixed(width: 375, height: 60))
    }
}
