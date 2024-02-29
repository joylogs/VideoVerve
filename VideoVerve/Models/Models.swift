//
//  Models.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 29/02/24.
//

import Foundation

struct Feeds2: Codable, Equatable {
    
    typealias Code = String
    
    var id: Int
    var postId: Code
    var videoUrl: String
    var thumbnail_url: String
    var username: String
    var likes: Int
    
}

struct FeedData2: Decodable {
    var status: String
    var data: [Feeds2]
}


extension Feeds2: Identifiable {
//    var id: String { postId }
}
