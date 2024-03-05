//
//  ProfileInteractor.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 03/03/24.
//

import SwiftUI
import Combine

protocol ProfileInteractor {
    func refreshProfileFeedsList() -> AnyPublisher<Void, Error>
    func load(feeds: LoadableSubject<LazyList<Profile>>)
}

struct UserProfileInteractor: ProfileInteractor {
    
    let webRepository: ProfileWebRepository
    let dbRepository: ProfileDBRepository
    let appState: Store<AppState>
    
    func load(feeds: LoadableSubject<LazyList<Profile>>) {
        let cancelBag = CancelBag()
        feeds.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        Just<Void>.withErrorType(Error.self).flatMap { [dbRepository] _ -> AnyPublisher<Bool, Error> in
                dbRepository.hasLoadedProfileFeeds()
            }.flatMap { hasLoaded -> AnyPublisher<Void, Error> in
                if hasLoaded {
                    return Just<Void>.withErrorType(Error.self)
                } else {
                    return self.refreshProfileFeedsList()
                }
            }.flatMap { [dbRepository] in
                dbRepository.feeds(search: "")
            }
            .sinkToLoadable { feeds.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
    func refreshProfileFeedsList() -> AnyPublisher<Void, Error> {
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

struct EmptyProfileInteractor: ProfileInteractor {
    
    func refreshProfileFeedsList() -> AnyPublisher<Void, Error> {
        return Just<Void>.withErrorType(Error.self)
    }
    
    func load(feeds: LoadableSubject<LazyList<Profile>>) {
    }
}

