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
