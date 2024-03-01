//
//  AppEnvironment.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 28/02/24.
//

import Foundation

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}


extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store(AppState())
        let session = configuredURLSession()
        
        let webRepositories = configuredWebRepositories(session: session)
        let dbRepositories = configuredDBRepositories(appState: appState)
        let interactors = configuredInteractors(appState: appState,
                                                dbRepositories: dbRepositories,
                                                webRepositories: webRepositories)
        
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        let systemEventsHandler = AppSystemEventsHandler(container: diContainer)
        
        return AppEnvironment(container: diContainer, systemEventsHandler: systemEventsHandler)
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
    
    private static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let feedsWebRepository = VideoFeedsWebRepository(
            session: session,
            baseURL: "https://api.jsonbin.io/v3/b/65e068cedc74654018ab8616")
        return .init(feedsRepository: feedsWebRepository)
    }
    
    private static func configuredDBRepositories(appState: Store<AppState>) -> DIContainer.DBRepositories {
        let persistentStore = CoreDataStack(version: CoreDataStack.Version.actual)
        let feedsDBRepository = VideoFeedsDBRepository(persistentStore: persistentStore)
        return .init(feedsRepository: feedsDBRepository)
        
    }
    
    private static func configuredInteractors(appState: Store<AppState>,
                                              dbRepositories: DIContainer.DBRepositories,
                                              webRepositories: DIContainer.WebRepositories) -> DIContainer.Interactors
    {
        let feedsInteractor = VideoFeedsInteractor(webRepository: webRepositories.feedsRepository,
                                                   dbRepository: dbRepositories.feedsRepository,
                                                   appState: appState)
        return .init(feedsInteractor: feedsInteractor)
    }
}


extension DIContainer {
    struct WebRepositories {
//        let imageRepository: ImageWebRepository
        let feedsRepository: FeedsWebRepository
//        let pushTokenWebRepository: PushTokenWebRepository
    }
    
    struct DBRepositories {
        let feedsRepository: FeedsDBRepository
    }
}
