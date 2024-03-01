//
//  AppEnvironment.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 28/02/24.
//

import Foundation


struct AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store(AppState())
        
        let session = configuredURLSession()
        
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60.0
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
        
    }
    
    private static func configuredWebRepositories(session: URLSession) ->  {
        let feedsWebRepository = VideoFeedsWebRepository(
            session: session,
            baseURL: "https://api.jsonbin.io/v3/b/65e068cedc74654018ab8616")
//        let imageWebRepository =
        return .init()
    }
}


