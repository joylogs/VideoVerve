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
    @State private var thumbImage: UIImage = UIImage(named: "turtlerock")!
    
    let feed: Feed
    private let player = AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!)
        
    var body: some View {
        VideoPlayer(player: player, videoOverlay: {
            if showOverlay {
                Image(uiImage: thumbImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
//                    .ignoresSafeArea()
                    
            }
            else {
                let _ = player.play()
            }
        })
        .onAppear(perform: {
            player.isMuted = true
        })
        .onDisappear(perform: {
            player.pause()
        })
        .onTapGesture {
            showOverlay.toggle()
        }
        .task {
            thumbImage = await generateThumbImage(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!)
        }
    }
    
    func generateThumbImage(url: URL) async -> UIImage {
        
        let asset: AVAsset = AVAsset(url: url)
        
        //Both of the below solution works,
        //the 2nd one utilizes the async-await strategy
        
        /*
        let assetImgGenerate: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.maximumSize = CGSize(width: 300, height: 0)
        assetImgGenerate.appliesPreferredTrackTransform = true

        let time: CMTime = CMTimeMake(value: 1, timescale: 30)
        let image: CGImage
        do {
            image = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        } catch {
            image = UIImage(named: "turtlerock")!.cgImage!
            print(error.localizedDescription)
        }
        */
                
        let generator = AVAssetImageGenerator(asset: asset)
        // Generate the equivalent of a 150-pixel-wide @2x image.
        generator.maximumSize = CGSize(width: 300, height: 0)

        // Configure the generator's time tolerance values.
        generator.requestedTimeToleranceBefore = .zero
        generator.requestedTimeToleranceAfter = CMTime(seconds: 2, preferredTimescale: 600)
        
        let image: CGImage
        
        do {
            // Generate an image at time zero. Access the image alone.
            if #available(iOS 16, *) {
                image = try await generator.image(at: .zero).image
            } else {
                // Fallback on earlier versions
                let time: CMTime = CMTimeMake(value: 1, timescale: 30)
                image = try generator.copyCGImage(at: time, actualTime: nil)
            }
        }
        catch {
            image = UIImage(named: "turtlerock")!.cgImage!
            print(error.localizedDescription)
        }
        
        return UIImage(cgImage: image)
    }
}


struct CustomVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        CustomVideoPlayer(feed: Feed.mockedData[0])
    }
}
