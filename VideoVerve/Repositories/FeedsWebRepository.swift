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
    func loadFeedDetails(feed: Feeds2) -> AnyPublisher<Feeds2.Details, Error>
}


struct VideoFeedsWebRepository: FeedsWebRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue: DispatchQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadFeeds() -> AnyPublisher<[Feeds2], Error> {
//        return call(endpoint:)
    }
    
    func loadFeedDetails(feed: Feeds2) -> AnyPublisher<Feeds2.Details, Error> {
        
    }
}

extension VideoFeedsWebRepository {
    enum API {
        case allFeeds
        case feedDetails(Feeds2)
    }
}

extension VideoFeedsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .allFeeds:
            return ""
        case let .feedDetails(feed):
            return ""
        }
    }
    var method: String {
        switch self {
        case .allFeeds, .feedDetails(_):
            return "GET"
        }
    }
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
}
