//
//  FeedDetails.swift
//  VideoVerve
//
//  Created by Joy Banerjee on 02/03/24.
//

import SwiftUI
import Combine

struct FeedDetails: View {
    
    let feed: Feed
    @Environment(\.injected) private var injected: DIContainer
    @State private var details: Loadable<Feed.Details>
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.feedDetails)
    }
    
    init(feed: Feed, details: Loadable<Feed.Details> = .notRequested) {
        self.feed = feed
        self._details = .init(initialValue: details)
    }
    
    var body: some View {
        content
            .navigationTitle(feed.postId)
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(routingUpdate) { self.routingState = $0 }
    }
    
    @ViewBuilder private var content: some View {
        switch details {
        case .notRequested:
            notRequestedView
        case .isLoading:
            loadingView
        case let .loaded(countryDetails):
            loadedView(countryDetails)
        case let .failed(error):
            failedView(error)
        }
    }
}

private extension FeedDetails {
    func loadFeedDetails() {
        injected.interactors.feedsInteractor
            .load(feedDetails: $details, feed: feed)
    }
}

// MARK: - Loading Content

private extension FeedDetails {
    var notRequestedView: some View {
        Text("").onAppear {
            self.loadFeedDetails()
        }
    }
    
    var loadingView: some View {
        VStack {
            ActivityIndicatorView()
            Button(action: {
                self.details.cancelLoading()
            }, label: { Text("Cancel loading") })
        }
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            self.loadFeedDetails()
        })
    }
}

// MARK: - Displaying Content

private extension FeedDetails {
    func loadedView(_ feedDetails: Feed.Details) -> some View {
        //TO DO: Check if the below can be incorporated
        ScrollView {
            CircleImage(image: feedDetails.profile_url)
                .offset(y: 10)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                HStack{
                    Text(feed.username)
                        .font(.title)
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(feed.likes) Likes")
                }
                
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                Text("About \(feed.postId)")
                    .font(.title2)
                Text("description")
            }
            .padding()
        }
    }
    
}

private extension Feed.Details {
    var profile_url: Image {
        return Image("turtlerock")
    }
}

// MARK: - ROUTING

extension FeedDetails {
    struct Routing: Equatable {
        var detailsSheet: Bool = false
    }
}

extension FeedDetails {
    var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.feedDetails)
    }
}



struct FeedDetails_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetails(feed: Feed.mockedData[0])
            .inject(.preview)
    }
}
