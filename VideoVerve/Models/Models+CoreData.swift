//
//  Models+CoreData.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 01/03/24.
//

import CoreData
import Foundation

extension FeedMO: ManagedEntity {}
//extension FeedDetailsManagedObject: ManagedEntity {}


extension Feed {
    
    init?(managedObject: FeedMO) {
        guard let username = managedObject.username,
            let postId = managedObject.postId,
            let videoUrl = managedObject.videoUrl,
            let thumbnail_url = managedObject.thumbnail_url
            else { return nil }
        
        self.init(postId: postId,
                  videoUrl: videoUrl,
                  thumbnail_url: thumbnail_url,
                  username: username,
                  likes: Int(managedObject.likes))
    }
    
    @discardableResult
    func store(in context: NSManagedObjectContext) -> FeedMO? {
        guard let feed = FeedMO.insertNew(in: context)
            else { return nil }
        feed.username = username
        feed.postId = postId
        feed.videoUrl = videoUrl
        feed.thumbnail_url = thumbnail_url
        feed.likes = Int32(likes)
        
        return feed
    }
    
    
    
}
