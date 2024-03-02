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
        let profileInteractor: ProfileInteractor
        
        init(feedsInteractor: FeedsInteractor, profileInteractor: ProfileInteractor) {
            self.feedsInteractor = feedsInteractor
            self.profileInteractor = profileInteractor
        }
        
        static var empty: Self {
            .init(feedsInteractor: EmptyFeedsInteractor(), profileInteractor: EmptyProfileInteractor())
        }
    }
}
