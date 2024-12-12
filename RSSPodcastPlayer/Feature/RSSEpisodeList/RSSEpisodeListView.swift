//
//  RSSEpisodeListView.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import SwiftUI

struct RSSEpisodeListView: View {
    
    var podcast: Podcast
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center) {
                    Text(podcast.title)
                        .font(.largeTitle)
                        .foregroundColor(Color.accentColor)
                        .padding(.top)
                    
                    AsyncImageGetter(url: podcast.image.url.stringToURL())
                    
                    HStack {
                        Text("Author" + ": ")
                            .font(.title3)
                            .foregroundColor(Color.accentColor)
                        Text(podcast.author)
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    Text(podcast.description)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    episodesList
                }
                .padding(.horizontal)
            }
            .background(Color.primaryBlue)
        }
    }
}

extension RSSEpisodeListView {
    
    private var episodesList: some View {
        Group {
            if podcast.episodes.isEmpty {
                Text("No episodes found")
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .padding()
            } else {
                LazyVStack {
                    ForEach(podcast.episodes) { episode in
                        NavigationLink(destination: RSSPlayerViewFactory.build(episode: episode, podcast: podcast)) {
                            EpisodeRowCell(episode: episode)
                                .padding(.vertical, 4)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .padding(.top, 8)
            }
        }
    }
}

#Preview {
    let mockPodcast = Podcast(
        id: UUID(),
        title: "Swiftly Speaking",
        description: "A podcast about all things Swift and iOS development. Tips, tricks, and deep dives into the latest Swift features.",
        author: "John Doe",
        image: RSSImage(url: "https://example.com/swiftly-speaking.jpg", title: "Speaking"),
        episodes: [
            Episode(
                id: UUID(),
                title: "Introduction to Swift 6",
                description: "An overview of the exciting new features coming to Swift 6.",
                pubDate: Date(),
                enclosure: Enclosure(url: URL("https://example.com/episode1.mp3")!, length: 60, type: "audio/mpeg"),
                duration: "3000"
            ),
            Episode(
                id: UUID(),
                title: "Understanding SwiftUI Animations",
                description: "Learn how to create stunning animations in SwiftUI.",
                pubDate: Date(),
                enclosure: Enclosure(url: URL("https://example.com/episode1.mp3")!, length: 50, type: "audio/mpeg"),
                duration: "4000"
            ),
            Episode(
                id: UUID(),
                title: "Concurrency in Swift",
                description: "Dive deep into async/await and structured concurrency in Swift.",
                pubDate: Date(),
                enclosure: Enclosure(url: URL("https://example.com/episode1.mp3")!, length: 45, type: "audio/mpeg"),
                duration: "5000"
            )
        ]
    )
    
    RSSEpisodeListView(podcast: mockPodcast)
}
