//
//  LoadedPodcast.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 10/12/24.
//

import SwiftUI

struct LoadedPodcastView: View {
    
    @Binding var podcast: Podcast?
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            if let podcast = podcast {
                VStack {
                    Text(podcast.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    AsyncImageGetter(url: podcast.image.url.stringToURL())
                    
                    Text(podcast.description)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primaryTextColor)
                        .padding(.top)
                    
                    NavigationLink(destination: RSSEpisodeListView(podcast: podcast)) {
                        Text("Episódios")
                            .padding()
                            .background(Color.primaryBlue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                           
                    }
                }
                .padding()
                .background(Color.accentColor)
                .cornerRadius(15)
                .padding(.horizontal)
            }
        }
    }
    
    private func getImage(url: URL?) -> some View {
        AsyncImage(url: url) { image in
            switch image {
            case .empty:
                EmptyView()
            case .success(let image):
                image.resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            case .failure(let error):
                Text("Failed to load image")
            @unknown default:
                EmptyView()
            }
        }
    }
}
