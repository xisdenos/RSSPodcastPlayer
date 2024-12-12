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
            
            AudioPlayerBox(viewModel: viewModel)
        }.onAppear {
            viewModel.play()
        }
        .onDisappear {
            viewModel.removeAudio()
        }
    }
}
