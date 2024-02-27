//
//  FeedList.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI

struct FeedList: View {
    
    @EnvironmentObject var feedData: FeedsModel
    
    var body: some View {
        List {
            ForEach(feedData.data.data) { feed in
                FeedItem()
            }
        }
    }
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList()
            .environmentObject(FeedsModel())
    }
}
