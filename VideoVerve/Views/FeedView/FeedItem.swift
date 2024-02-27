//
//  FeedItem.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI
import AVKit

struct FeedItem: View {
    
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "SampleVideo_1280x720_1mb",
                                                      withExtension: "mp4")!)
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .frame(width: 320, height: 180, alignment: .top)
            
            HStack {
                Text("23 Likes")
                    .font(.caption)
//                Spacer()
            }
//            .padding(EdgeInsets(top: 5, leading: 35, bottom: 0, trailing: 0))
            Spacer()
        }
    }
}

struct FeedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeedItem()
    }
}
