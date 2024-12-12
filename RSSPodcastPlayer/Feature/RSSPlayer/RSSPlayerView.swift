//
//  RSSPlayerView.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import SwiftUI

struct RSSPlayerView: View {
    
    var podcast: Podcast
    var episode: Episode
    
    var body: some View {
        Text(episode.title)
    }
}
