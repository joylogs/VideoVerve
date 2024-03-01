//
//  Models.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 29/02/24.
//

import Foundation

struct Feed: Codable, Equatable {
    
    typealias Code = String
    
    var postId: Code
    var videoUrl: String
    var thumbnail_url: String
    var username: String
    var likes: Int
    
}

struct FeedData2: Decodable {
    var status: String
    var data: [Feed]
}


extension Feed: Identifiable {
    var id: String { postId }
}

extension Feed {
    struct Details: Codable, Equatable {
        
    }
}
