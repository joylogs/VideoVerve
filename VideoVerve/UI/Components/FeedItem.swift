//
//  FeedItem.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI
import AVKit

struct FeedItem: View {
    
    let feed: Feed
    
    @State var player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)
//    AVPlayer(url: Bundle.main.url(forResource: "SampleVideo_1280x720_1mb",
//                                                      withExtension: "mp4")!)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(feed.username)")
                .font(.callout)
                .bold()
            VideoPlayer(player: player)
                .frame(width: 320, height: 180, alignment: .top)
            
            HStack {
                Text("\(feed.likes) Likes")
                    .font(.caption)
            }
//            .padding(EdgeInsets(top: 5, leading: 35, bottom: 0, trailing: 0))
//            Spacer()
            Divider()
        }
    }
}

struct FeedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeedItem(feed: Feed.mockedData[0])
            .previewLayout(.fixed(width: 375, height: 60))
    }
}
