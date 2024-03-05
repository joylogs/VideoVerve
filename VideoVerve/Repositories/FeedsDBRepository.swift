//
//  FeedsDBRepository.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 01/03/24.
//

import CoreData
import Combine

protocol FeedsDBRepository {
    func hasLoadedFeeds() -> AnyPublisher<Bool, Error>
    
    func store(feeds: [Feed]) -> AnyPublisher<Void, Error>
    func store(feedDetails: Feed.Details, for feed: Feed) -> AnyPublisher<Feed.Details?, Error>
    func feedDetails(feed: Feed) -> AnyPublisher<Feed.Details?, Error>    
    func feeds(search: String) -> AnyPublisher<LazyList<Feed>, Error>
}


struct VideoFeedsDBRepository: FeedsDBRepository {

    let persistentStore: PersistentStore

    func hasLoadedFeeds() -> AnyPublisher<Bool, Error> {
        let fetchRequest = FeedMO.justOneFeed()
        return persistentStore
            .count(fetchRequest)
            .map { $0 > 0 }
            .eraseToAnyPublisher()
    }

    func store(feeds: [Feed]) -> AnyPublisher<Void, Error> {
        return persistentStore
            .update { context in
                feeds.forEach {
                    $0.store(in: context)
                }
            }
    }
    
    func feeds(search: String) -> AnyPublisher<LazyList<Feed>, Error> {
        let fetchRequest = FeedMO.feeds(search: search, locale: Locale(identifier: "en"))
        return persistentStore
            .fetch(fetchRequest) {
                Feed(managedObject: $0)
            }
            .eraseToAnyPublisher()
    }

    func store(feedDetails: Feed.Details, for feed: Feed) -> AnyPublisher<Feed.Details?, Error> {
        return persistentStore
            .update { context in
                let parentRequest = FeedMO.feeds(postId: [feed.postId])
                guard let parent = try context.fetch(parentRequest).first else {return nil}

                let details = feedDetails.store(in: context, feed: parent)
                return details.flatMap { Feed.Details(managedObject: $0) }
            }
    }
    
    func feedDetails(feed: Feed) -> AnyPublisher<Feed.Details?, Error> {
        let fetchRequest = FeedDetailsMO.details(feed: feed)
        return persistentStore
            .fetch(fetchRequest) {
                Feed.Details(managedObject: $0)
            }
            .map { $0.first }
            .eraseToAnyPublisher()
    }
}

// MARK: - Fetch Requests

extension FeedMO {
    
    static func justOneFeed() -> NSFetchRequest<FeedMO> {
        let request = newFetchRequest()
        request.predicate = NSPredicate(format: "username == %@", "user123")
        request.fetchLimit = 1
        return request
    }
    
    static func feeds(search: String, locale: Locale) -> NSFetchRequest<FeedMO> {
        let request = newFetchRequest()
        if search.count == 0 {
            request.predicate = NSPredicate(value: true)
        } else {
        }
        request.sortDescriptors = [NSSortDescriptor(key: "username", ascending: true)]
        request.fetchBatchSize = 10
        return request
    }
    
    static func feeds(postId: [String]) -> NSFetchRequest<FeedMO> {
        let request = newFetchRequest()
        request.predicate = NSPredicate(format: "postId in %@", postId)
        request.fetchLimit = postId.count
        return request
    }
}


extension FeedDetailsMO {
    static func details(feed: Feed) -> NSFetchRequest<FeedDetailsMO> {
        let request = newFetchRequest()
        request.predicate = NSPredicate(format: "feed.username == %@", feed.username)
        request.fetchLimit = 1
        return request
    }
}
