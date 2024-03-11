//
//  FeedItem.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI
import Combine
import AVKit

struct FeedItem: View {
    let feed: Feed
    
    //    @State private var feed: Loadable<Feed>
    
    //    init(feed: Feed) {
    //        self.feed = feed
    //    }
    
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
            
            VideoPlayer(player: player(feed: feed))
                .frame(width: 320, height: 180, alignment: .top)
                .overlay {
                    Image("turtlerock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .ignoresSafeArea()
                }
            
            Divider()
        }
    }
    
    func generateThumbImage(url: URL) -> UIImage {
        
        var asset: AVAsset = AVAsset(url: url)
        var assetImgGenerate: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        assetImgGenerate.appliesPreferredTrackTransform = true
        
        var time: CMTime = CMTimeMake(value: 1, timescale: 30)
        var image: CGImage
        do {
            image = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        } catch {
            image = UIImage(named: "turtlerock")!.cgImage!
            print(error.localizedDescription)
        }
        
        var frameImage: UIImage = UIImage(cgImage: image)
        
        return frameImage
    }
    
    func player(feed: Feed) -> AVPlayer {
        //Ignoring the feed Url for now
        let p = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)
        return p
    }
}

struct FeedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeedItem(feed: Feed.mockedData[0])
            .previewLayout(.fixed(width: 375, height: 60))
    }
}
