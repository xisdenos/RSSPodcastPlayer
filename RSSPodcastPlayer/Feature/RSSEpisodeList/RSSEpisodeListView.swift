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
                        .padding()
                    
                    AsyncImageGetter(url: podcast.image.url.stringToURL())
                    
                    Text(podcast.description)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("Author" + ": ")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                    Text(podcast.title)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                }
            }
        }.background(Color.blue)
    }
}
