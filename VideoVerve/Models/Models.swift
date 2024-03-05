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

extension Feed: Identifiable {
    var id: String { postId }
}

extension Feed {
    struct Details: Codable, Equatable {
        var profileUrl: String
        var feedDescription: String
        
        init(profileUrl: String, feedDescription: String) {
            self.profileUrl = profileUrl
            self.feedDescription = feedDescription
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<Feed.Details.CodingKeys> = try decoder.container(keyedBy: Feed.Details.CodingKeys.self)
            self.profileUrl = try container.decode(String.self, forKey: Feed.Details.CodingKeys.profileUrl)
            self.feedDescription = try container.decode(String.self, forKey: Feed.Details.CodingKeys.feedDescription)
        }
    }
}

struct ProfileResponse: Codable, Equatable {
    var status: String
    var data: ProfileData
}

extension ProfileResponse {
    struct ProfileData: Codable, Equatable {
        var username: String
        var profilePictureUrl: String
        var posts: [Profile]
    }
}

extension ProfileResponse {
    struct Profile: Codable, Equatable {
        
        typealias Code = String
        
        var postId: Code
        var videoUrl: String
        var thumbnail_url: String
        var likes: Int
        
        init(postId: Code, videoUrl: String, thumbnail_url: String, likes: Int) {
            self.postId = postId
            self.videoUrl = videoUrl
            self.thumbnail_url = thumbnail_url
            self.likes = likes
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.postId = try container.decode(Feed.Code.self, forKey: .postId)
            self.videoUrl = try container.decode(String.self, forKey: .videoUrl)
            self.thumbnail_url = try container.decode(String.self, forKey: .thumbnail_url)
            self.likes = try container.decode(Int.self, forKey: .likes)
        }
    }
}

extension ProfileResponse.Profile: Identifiable {
    var id: String { postId }
}
