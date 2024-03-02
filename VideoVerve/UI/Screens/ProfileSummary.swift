//
//  ProfileSummary.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 03/03/24.
//

import SwiftUI
import Combine

struct ProfileSummary: View {
    
    @State private(set) var profileFeeds: Loadable<LazyList<Profile>>
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.profile)
    }
    @Environment(\.injected) private var injected: DIContainer
    
    init(profileFeeds: Loadable<LazyList<Profile>> = .notRequested) {
        self._profileFeeds = .init(initialValue: profileFeeds)
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                self.content
                    .navigationTitle("My Feeds")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
        }
        .onReceive(routingUpdate) { self.routingState = $0 }
    }
    
    @ViewBuilder private var content: some View {
        switch profileFeeds {
        case .notRequested:
            notRequestedView
        case let .isLoading(last, _):
            loadingView(last)
        case let .loaded(feeds):
            loadedView(feeds, showLoading: false)
        case let .failed(error):
            failedView(error)
        }
    }
}


private extension ProfileSummary {
    func reloadFeeds() {
        injected.interactors.profileInteractor
            .load(feeds: $profileFeeds)
    }
}

private extension ProfileSummary {
    var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.profile)
    }
}

// MARK: - DISPLAYING CONTENT

extension ProfileSummary {
    func loadedView(_ profileFeeds: LazyList<Profile>, showLoading: Bool) -> some View {
        VStack {
            if showLoading {
                ActivityIndicatorView().padding()
            }
            CircleImage(image: Image("turtlerock"))
                .scaleEffect(1.0/1.5, anchor: .top)
            
            Text("username")
                .bold()
                .font(.title3)
            Divider()
                .bold()
            
            List(profileFeeds) { profile in
                ProfileRow(profile: profile)
                .listRowSeparator(.hidden)
            }
            
            .id(profileFeeds.count)
        }
    }
    
}

private extension ProfileSummary {
    var notRequestedView: some View {
        Text("").onAppear(perform: reloadFeeds)
    }
    
    func loadingView(_ previouslyLoaded: LazyList<Profile>?) -> some View {
        if let feeds = previouslyLoaded {
            return AnyView(loadedView(feeds, showLoading: true))
        } else {
            return AnyView(ActivityIndicatorView().padding())
        }
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            self.reloadFeeds()
        })
    }
}


// MARK: - ROUTING

extension ProfileSummary {
    struct Routing: Equatable {
        var profile: Profile.Code?
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profileFeeds: .loaded(Profile.mockedData.lazyList))
    }
}

