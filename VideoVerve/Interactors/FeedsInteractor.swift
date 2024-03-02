//
//  FeedsInteractor.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 01/03/24.
//

import SwiftUI
import Combine

protocol FeedsInteractor {
    func refreshFeedsList() -> AnyPublisher<Void, Error>
    func load(feeds: LoadableSubject<LazyList<Feed>>)
    func load(feedDetails: LoadableSubject<Feed.Details>, feed: Feed)
}

struct VideoFeedsInteractor: FeedsInteractor {
    
    let webRepository: FeedsWebRepository
    let dbRepository: FeedsDBRepository
    let appState: Store<AppState>
    
    
    func load(feeds: LoadableSubject<LazyList<Feed>>) {
        let cancelBag = CancelBag()
        feeds.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        Just<Void>.withErrorType(Error.self).flatMap { [dbRepository] _ -> AnyPublisher<Bool, Error> in
                dbRepository.hasLoadedFeeds()
            }.flatMap { hasLoaded -> AnyPublisher<Void, Error> in
                if hasLoaded {
                    return Just<Void>.withErrorType(Error.self)
                } else {
                    return self.refreshFeedsList()
                }
            }.flatMap { [dbRepository] in
                dbRepository.feeds(search: "")
            }
            .sinkToLoadable { feeds.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
    func load(feedDetails: LoadableSubject<Feed.Details>, feed: Feed) {
        let cancelBag = CancelBag()
        feedDetails.wrappedValue.setIsLoading(cancelBag: cancelBag)

        dbRepository
            .feedDetails(feed: feed)
            .flatMap { details -> AnyPublisher<Feed.Details?, Error> in
                if details != nil {
                    return Just<Feed.Details?>.withErrorType(details, Error.self)
                } else {
                    return self.loadAndStoreFeedDetailsFromWeb(feed: feed)
                }
            }
            .sinkToLoadable { feedDetails.wrappedValue = $0.unwrap() }
            .store(in: cancelBag)
    }
    
    private func loadAndStoreFeedDetailsFromWeb(feed: Feed) -> AnyPublisher<Feed.Details?, Error> {
        return webRepository
            .loadFeedDetails(feed: feed)
            .ensureTimeSpan(requestHoldBackTimeInterval)
            .flatMap { [dbRepository] in
                dbRepository.store(feedDetails: $0, for: feed)
            }
            .eraseToAnyPublisher()
    }
    
    func refreshFeedsList() -> AnyPublisher<Void, Error> {
        return webRepository
            .loadFeeds()
            .ensureTimeSpan(requestHoldBackTimeInterval)
            .flatMap { [dbRepository] in
                dbRepository.store(feeds: $0)
            }
            .eraseToAnyPublisher()
    }
    
    private var requestHoldBackTimeInterval: TimeInterval {
        return 0.5
    }
}

struct EmptyFeedsInteractor: FeedsInteractor {
    
    func refreshFeedsList() -> AnyPublisher<Void, Error> {
        return Just<Void>.withErrorType(Error.self)
    }
    
    func load(feeds: LoadableSubject<LazyList<Feed>>) {
    }
    
    func load(feedDetails: LoadableSubject<Feed.Details>, feed: Feed) {
    }
}

