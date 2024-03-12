//
//  MockedData.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 01/03/24.
//

import Foundation

extension Feed {    
    static let mockedData: [Feed] = [
        Feed(postId: "post_id_1", videoUrl: "thisisastring", thumbnail_url: "thisisastring", username: "user123", likes: 12),
        Feed(postId: "post_id_2", videoUrl: "thisisastring", thumbnail_url: "thisisastring", username: "user234", likes: 15),
        Feed(postId: "post_id_3", videoUrl: "thisisastring", thumbnail_url: "thisisastring", username: "user345", likes: 20)
    ]
}

extension ProfileResponse.Profile {
    static let mockedData: [ProfileResponse.Profile] = [
        ProfileResponse.Profile(postId: "post_id_1", videoUrl: "thisisastring", thumbnail_url: "thisisastring", likes: 12),
        ProfileResponse.Profile(postId: "post_id_2", videoUrl: "thisisastring", thumbnail_url: "thisisastring", likes: 15),
        ProfileResponse.Profile(postId: "post_id_3", videoUrl: "thisisastring", thumbnail_url: "thisisastring", likes: 20)
    ]
}
