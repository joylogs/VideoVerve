//
//  CustomVideoPlayer.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 11/03/24.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: View {
    
    @State private var showOverlay = true
    let feed: Feed
    
    var body: some View {
        VideoPlayer(player: player(feed: feed))
            .frame(width: 320, height: 180, alignment: .top)
            .overlay {
                if showOverlay {
                    Image("turtlerock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .ignoresSafeArea()
                }
                else {
                    
                }
            }
            .onTapGesture {
                showOverlay.toggle()
            }
    }
    
    func player(feed: Feed) -> AVPlayer {
        //Ignoring the feed Url for now
        let p = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)
        return p
    }
    
    func generateThumbImage(url: URL) -> UIImage {
        
        let asset: AVAsset = AVAsset(url: url)
        let assetImgGenerate: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        assetImgGenerate.appliesPreferredTrackTransform = true
        
        let time: CMTime = CMTimeMake(value: 1, timescale: 30)
        let image: CGImage
        do {
            image = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        } catch {
            image = UIImage(named: "turtlerock")!.cgImage!
            print(error.localizedDescription)
        }
        
        let frameImage: UIImage = UIImage(cgImage: image)
        
        return frameImage
    }
}


struct CustomVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        CustomVideoPlayer(feed: Feed.mockedData[0])
    }
}
