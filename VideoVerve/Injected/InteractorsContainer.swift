//
//  InteractorsContainer.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 01/03/24.
//

import Foundation

extension DIContainer {
    struct Interactors {
        let feedsInteractor: FeedsInteractor
        
        init(feedsInteractor: FeedsInteractor) {
            self.feedsInteractor = feedsInteractor
        }
        
        static var empty: Self {
            .init(feedsInteractor: EmptyFeedsInteractor())
        }
    }
}
