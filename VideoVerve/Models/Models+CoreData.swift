//
//  Models+CoreData.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 01/03/24.
//

import CoreData
import Foundation

extension FeedMO: ManagedEntity {}
extension FeedDetailsMO: ManagedEntity {}
extension ProfileMO: ManagedEntity {}

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

extension Profile {
    
    init?(managedObject: ProfileMO) {
        guard
            let postId = managedObject.postId,
            let videoUrl = managedObject.videoUrl,
            let thumbnail_url = managedObject.thumbnail_url
            else { return nil }
        
        self.init(postId: postId,
                  videoUrl: videoUrl,
                  thumbnail_url: thumbnail_url,
                  likes: Int(managedObject.likes))
    }
    
    @discardableResult
    func store(in context: NSManagedObjectContext) -> ProfileMO? {
        guard let profile = ProfileMO.insertNew(in: context)
            else { return nil }
        profile.postId = postId
        profile.videoUrl = videoUrl
        profile.thumbnail_url = thumbnail_url
        profile.likes = Int32(likes)
        
        return profile
    }
}


extension Feed.Details {
    
    init?(managedObject: FeedDetailsMO) {
        guard let profileUrl = managedObject.profileUrl,
                let feedDescription = managedObject.feedDescription
            else { return nil }
        
        self.init(profileUrl: profileUrl, feedDescription: feedDescription)
    }
}

extension Feed.Details {
    @discardableResult
    func store(in context: NSManagedObjectContext,
               feed: FeedMO) -> FeedDetailsMO? {
        guard let details = FeedDetailsMO.insertNew(in: context)
            else { return nil }
//       Store any further Info needed
        details.profileUrl = profileUrl
        details.feedDescription = feedDescription
        feed.feedDetails = details
        return details
    }
}
