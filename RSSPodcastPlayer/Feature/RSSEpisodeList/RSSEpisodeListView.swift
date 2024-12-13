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
