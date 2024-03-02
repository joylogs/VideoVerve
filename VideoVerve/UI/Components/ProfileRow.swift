//
//  ProfileRow.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 03/03/24.
//

import SwiftUI
import AVKit

struct ProfileRow: View {
    
    let profile: Profile
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CircleImage(image: Image("turtlerock"))
                .scaleEffect(1.0 / 3.0)

                Text("\(profile.postId)")
                    .font(.callout)
                    .bold()
                Spacer()
                
                HStack {
                    Text("\(profile.likes) Likes")
                        .font(.caption)
                }
            }
            VideoPlayer(player: player(profile: profile))
                .frame(width: 320, height: 180, alignment: .top)

            Divider()
        }
    }
    
    func player(profile: Profile) -> AVPlayer {
        //Ignoring the feed Url for now
        let p = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)
        return p
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow(profile: Profile.mockedData[0])
    }
}
