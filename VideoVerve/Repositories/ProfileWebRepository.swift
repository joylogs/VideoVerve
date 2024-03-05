//
//  ProfileWebRepository.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 03/03/24.
//

import SwiftUI
import Combine

protocol ProfileWebRepository: WebRepository {
    func loadFeeds() -> AnyPublisher<ProfileResponse, Error>
}

struct UserProfileWebRepository: ProfileWebRepository {
    
    let session: URLSession
    let baseURL: String
    let bgQueue: DispatchQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadFeeds() -> AnyPublisher<ProfileResponse, Error> {
        let value: AnyPublisher<ProfileResponse, Error> = call(endpoint: API.profile)
        
        let someVal = value.tryMap { profileResponse -> ProfileResponse in
//            print(profileResponse)
            return profileResponse
        }.eraseToAnyPublisher()
        
        return someVal
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
            return "/d3f326e5515c29896063"
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


