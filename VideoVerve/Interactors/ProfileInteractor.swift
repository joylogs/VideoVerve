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
    func load(feeds: LoadableSubject<LazyList<ProfileResponse.Profile>>)
}

struct UserProfileInteractor: ProfileInteractor {
    
    let webRepository: ProfileWebRepository
    let dbRepository: ProfileDBRepository
    let appState: Store<AppState>
    
    func load(feeds: LoadableSubject<LazyList<ProfileResponse.Profile>>) {
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
//        return webRepository
//            .loadFeeds()
//            .ensureTimeSpan(requestHoldBackTimeInterval)
//            .flatMap { [dbRepository] (xyz: [ProfileResponse]) in
//                let abc: [ProfileResponse.Profile] = xyz[0].data.posts
//                return dbRepository.store(feeds: abc)
//            }
//            .eraseToAnyPublisher()
        
        return webRepository.loadFeeds().ensureTimeSpan(requestHoldBackTimeInterval).flatMap { response in
            let res = response.data.posts
            return dbRepository.store(feeds: res)
        }
        .eraseToAnyPublisher()
    }
    
//    private func testFunc() -> AnyPublisher<Void, Error> {
//        let value = webRepository.loadFeeds().ensureTimeSpan(0.5).flatMap { [ProfileResponse] in
//            <#code#>
//        }
//        return value
//    }
    
    private var requestHoldBackTimeInterval: TimeInterval {
        return 0.5
    }
}

struct EmptyProfileInteractor: ProfileInteractor {
    
    func refreshProfileFeedsList() -> AnyPublisher<Void, Error> {
        return Just<Void>.withErrorType(Error.self)
    }
    
    func load(feeds: LoadableSubject<LazyList<ProfileResponse.Profile>>) {
    }
}

