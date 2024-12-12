//
//  RSSPlayerView.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import SwiftUI
import Observation

struct RSSPlayerView: View {
    
    @StateObject var viewModel: RSSPlayerViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.episode.title)
                .font(.headline)
                .foregroundColor(Color.accentColor)
            ScrollView {
                Text(viewModel.episode.description.removingHTMLTags())
                    .foregroundColor(Color.primaryWhite)
            }
            
            AudioPlayerBox(viewModel: viewModel)
        }
        .padding()
        .background(Color.primaryBlue)
        .onAppear {
            viewModel.play()
        }
        .onDisappear {
            viewModel.removeAudio()
        }
    }
}
