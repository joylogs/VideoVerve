//
//  ProfileWebRepository.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 03/03/24.
//

import SwiftUI
import Combine

protocol ProfileWebRepository: WebRepository {
    func loadFeeds() -> AnyPublisher<[Profile], Error>
}

struct UserProfileWebRepository: ProfileWebRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue: DispatchQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadFeeds() -> AnyPublisher<[Profile], Error> {
        return call(endpoint: API.profile)
    }
}

extension UserProfileWebRepository {
    enum API {
        case profile
    }
}

extension UserProfileWebRepository.API: APICall {
    var path: String {
        switch self {
        case .profile:
            return "/38786b062e095a6155fc"
        }
    }
    var method: String {
        switch self {
        case .profile:
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


