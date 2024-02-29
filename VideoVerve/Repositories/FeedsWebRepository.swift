//
//  FeedsWebRepository.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 29/02/24.
//

import Foundation
import Combine

protocol FeedsWebRepository: WebRepository {
    func loadFeeds() -> AnyPublisher<[Feeds2], Error>
    func loadFeedDetails(feed: Feeds2) -> AnyPublisher<>
}

