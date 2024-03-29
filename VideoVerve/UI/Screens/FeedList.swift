//
//  FeedList.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 27/02/24.
//

import SwiftUI
import Combine

struct FeedList: View {
    
    @State private(set) var feeds: Loadable<LazyList<Feed>>
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.feedsList)
    }
    @Environment(\.injected) private var injected: DIContainer
    @State private var showingProfile: Bool = false
    
    init(feeds: Loadable<LazyList<Feed>> = .notRequested) {
        self._feeds = .init(initialValue: feeds)
    }
    
    var body: some View {
        NavigationView {
            self.content
                .navigationTitle("Feeds")
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .onReceive(routingUpdate) { self.routingState = $0 }
    }
    
    @ViewBuilder private var content: some View {
        switch feeds {
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


private extension FeedList {
    func reloadFeeds() {
        injected.interactors.feedsInteractor
            .load(feeds: $feeds)
    }
}

private extension FeedList {
    var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.feedsList)
    }
}

// MARK: - DISPLAYING CONTENT

extension FeedList {
    func loadedView(_ feeds: LazyList<Feed>, showLoading: Bool) -> some View {
        VStack {
            if showLoading {
                ActivityIndicatorView().padding()
            }
            List(feeds) { feed in
                NavigationLink (
                    destination: self.detailsView(feed: feed),
                    tag: feed.postId,
                    selection: self.routingBinding.feedDetails) {
                        FeedItem(feed)
                    }
                    .listRowSeparator(.hidden)
            }.environment(\.defaultMinListRowHeight, 200)
//            .toolbar {
//                Button {
//                    showingProfile.toggle()
//                } label: {
//                    Label("User Profile", systemImage: "person.crop.circle")
//                }
//            }
//            .sheet(isPresented: $showingProfile) {
//                ProfileSummary()
//            }
            .refreshable {
                DispatchQueue.main.async {
                    self.reloadFeeds()
                }
            }
            .id(feeds.count)
        }
    }
    
    func detailsView(feed: Feed) -> some View {
        FeedDetails(feed: feed)
    }
}

private extension FeedList {
    var notRequestedView: some View {
        Text("").onAppear(perform: reloadFeeds)
    }
    
    func loadingView(_ previouslyLoaded: LazyList<Feed>?) -> some View {
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

extension FeedList {
    struct Routing: Equatable {
        var feedDetails: Feed.Code?
    }
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList(feeds: .loaded(Feed.mockedData.lazyList))
    }
}
