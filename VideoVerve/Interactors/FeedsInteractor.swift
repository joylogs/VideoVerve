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
    func load(feeds: LoadableSubject<LazyList<Feeds2>>)
    func load(feedDetails: LoadableSubject<Feeds2.Details>, feed: Feeds2)
}

struct VideoFeedsInteractor: FeedsInteractor {
    
    let webRepository: FeedsWebRepository
    let dbRepository: 
    
    
    func load(feeds: LoadableSubject<LazyList<Feeds2>>) {
        
    }
    
    func load(feedDetails: LoadableSubject<Feeds2.Details>, feed: Feeds2) {
        
    }
    
    func refreshFeedsList() -> AnyPublisher<Void, Error> {
        
    }
}
