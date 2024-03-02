//
//  FeedsWebRepository.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 29/02/24.
//

import Foundation
import Combine

protocol FeedsWebRepository: WebRepository {
    func loadFeeds() -> AnyPublisher<[Feed], Error>
    func loadFeedDetails(feed: Feed) -> AnyPublisher<Feed.Details, Error>
}


struct VideoFeedsWebRepository: FeedsWebRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue: DispatchQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadFeeds() -> AnyPublisher<[Feed], Error> {
        return call(endpoint: API.allFeeds)
    }
    
    func loadFeedDetails(feed: Feed) -> AnyPublisher<Feed.Details, Error> {
        let request: AnyPublisher<[Feed.Details], Error> = call(endpoint: API.feedDetails(feed))
        return request
            .tryMap { array -> Feed.Details in
                
                guard let details = array.first
                    else {
                    print("here is the error")
                    throw APIError.unexpectedResponse
                }
                
                return details
            }
            .eraseToAnyPublisher()
    }
}

extension VideoFeedsWebRepository {
    enum API {
        case allFeeds
        case feedDetails(Feed)
    }
}

extension VideoFeedsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .allFeeds:
//            return "/65e068cedc74654018ab8616"
            return "/d83770329296476a73e0"
        case let .feedDetails(feed):
            return "/63940b729e608643fa2c"
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
    func body() throws -> Data? {
        return nil
    }
}
