//
//  CustomVideoPlayer.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 11/03/24.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: View {
    
    @State private var showOverlay = false
    let feed: Feed
    private let player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)

    
    var body: some View {
//        GeometryReader { geometry in
            VideoPlayer(player: player, videoOverlay: {
//                if showOverlay {
//                    Image("turtlerock")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .ignoresSafeArea()
//                }
//                else {
//                    let _ = player.play()
//                }
            })
//            .ignoresSafeArea()
//            .frame(width: geometry.size.width * 16 / 9, height: geometry.size.height)
            
            .onAppear(perform: {
                player.isMuted = true
            })
            .onDisappear(perform: {
                player.pause()
            })
            .onTapGesture {
                showOverlay.toggle()
            }
//        }
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
