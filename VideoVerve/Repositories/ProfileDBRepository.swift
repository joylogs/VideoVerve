//
//  ProfileDBRepository.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 03/03/24.
//

import Combine
import CoreData

protocol ProfileDBRepository {
    func hasLoadedProfileFeeds() -> AnyPublisher<Bool, Error>
    
    func store(feeds: [Profile]) -> AnyPublisher<Void, Error>
    func feeds(search: String) -> AnyPublisher<LazyList<Profile>, Error>
}

struct UserProfileDBRepository: ProfileDBRepository {

    let persistentStore: PersistentStore

    func hasLoadedProfileFeeds() -> AnyPublisher<Bool, Error> {
        let fetchRequest = ProfileMO.justOneFeed()
        return persistentStore
            .count(fetchRequest)
            .map { $0 > 0 }
            .eraseToAnyPublisher()
    }

    func store(feeds: [Profile]) -> AnyPublisher<Void, Error> {
        return persistentStore
            .update { context in
                feeds.forEach {
                    $0.store(in: context)
                }
            }
    }
    
    func feeds(search: String) -> AnyPublisher<LazyList<Profile>, Error> {
        let fetchRequest = ProfileMO.feeds(search: search, locale: Locale(identifier: "en"))
        return persistentStore
            .fetch(fetchRequest) {
                Profile(managedObject: $0)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Fetch Requests

extension ProfileMO {
    
    static func justOneFeed() -> NSFetchRequest<ProfileMO> {
        let request = newFetchRequest()
        request.predicate = NSPredicate(format: "postId == %@", "post_id_1")
        request.fetchLimit = 1
        return request
    }
    
    static func feeds(search: String, locale: Locale) -> NSFetchRequest<ProfileMO> {
        let request = newFetchRequest()
        if search.count == 0 {
            request.predicate = NSPredicate(value: true)
        } else {
            //If we are adding Search we can add this
        }
        request.sortDescriptors = [NSSortDescriptor(key: "postId", ascending: true)]
        request.fetchBatchSize = 10
        return request
    }
    
    static func feeds(postId: [String]) -> NSFetchRequest<ProfileMO> {
        let request = newFetchRequest()
        request.predicate = NSPredicate(format: "postId in %@", postId)
        request.fetchLimit = postId.count
        return request
    }
}
