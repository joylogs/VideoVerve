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
    
    
    init(postId: Code, videoUrl: String, thumbnail_url: String, username: String, likes: Int) {
        self.postId = postId
        self.videoUrl = videoUrl
        self.thumbnail_url = thumbnail_url
        self.username = username
        self.likes = likes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postId = try container.decode(Feed.Code.self, forKey: .postId)
        self.videoUrl = try container.decode(String.self, forKey: .videoUrl)
        self.thumbnail_url = try container.decode(String.self, forKey: .thumbnail_url)
        self.username = try container.decode(String.self, forKey: .username)
        self.likes = try container.decode(Int.self, forKey: .likes)
    }
    
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
