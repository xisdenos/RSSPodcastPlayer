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
                VStack {
                    Text(podcast.title)
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .padding()
                    
                    AsyncImageGetter(url: podcast.image.url.stringToURL())
                    
                    Text(podcast.description)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                    
                    HStack {
                        Text("Author" + ": ")
                            .font(.title3)
                            .foregroundColor(.green)
                        Text(podcast.author)
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }.background(Color.blue)
    }
}
