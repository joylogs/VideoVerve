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
//    func store(feedDetails: Feed.Details, for feed: Feed) -> AnyPublisher<Feed.Details?, Error>
//    func feedDetails(feed: Feed) -> AnyPublisher<Feed.Details?, Error>
    
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

//    func store(feedDetails: Feed.Details, for feed: Feed) -> AnyPublisher<Feed.Details?, Error> {
//        return persistentStore
//            .update { context in
//                let parentRequest = CountryMO.countries(alpha3codes: [country.alpha3Code])
//                guard let parent = try context.fetch(parentRequest).first
//                    else { return nil }
//                let neighbors = CountryMO.countries(alpha3codes: countryDetails.borders)
//                let borders = try context.fetch(neighbors)
//                let details = countryDetails.store(in: context, country: parent, borders: borders)
//                return details.flatMap { Country.Details(managedObject: $0) }
//            }
//    }

//    func feedDetails(feed: Feed) -> AnyPublisher<Feed.Details?, Error> {
//        let fetchRequest = CountryDetailsMO.details(country: country)
//        return persistentStore
//            .fetch(fetchRequest) {
//                Country.Details(managedObject: $0)
//            }
//            .map { $0.first }
//            .eraseToAnyPublisher()
//    }
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
//            let localeId = locale.shortIdentifier
//            let nameMatch = NSPredicate(format: "name CONTAINS[cd] %@", search)
//            let localizedMatch = NSPredicate(format:
//            "(SUBQUERY(nameTranslations,$t,$t.locale == %@ AND $t.name CONTAINS[cd] %@).@count > 0)", localeId, search)
//            request.predicate = NSCompoundPredicate(type: .or, subpredicates: [nameMatch, localizedMatch])
        }
        request.sortDescriptors = [NSSortDescriptor(key: "username", ascending: true)]
        request.fetchBatchSize = 10
        return request
    }
    
    static func countries(alpha3codes: [String]) -> NSFetchRequest<FeedMO> {
        let request = newFetchRequest()
        request.predicate = NSPredicate(format: "alpha3code in %@", alpha3codes)
        request.fetchLimit = alpha3codes.count
        return request
    }
}


