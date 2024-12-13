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
            
            EpisodeTitleView(title: viewModel.episode.title)

            EpisodeDescriptionView(description: viewModel.episode.description)
            
            AudioPlayerBox(viewModel: viewModel)
                .frame(maxWidth: .infinity)
        }
        .background(Color.primaryBlue)
        .onAppear {
            viewModel.play()
        }
        .onDisappear {
            viewModel.removeAudio()
        }
        
        .alert(isPresented: .constant(viewModel.audioErrorFeedbackMessage != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.audioErrorFeedbackMessage ?? ""),
                dismissButton: .default(Text("OK")) {
                    viewModel.audioErrorFeedbackMessage = nil
                }
            )
        }
    }
}

struct EpisodeTitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(Color.accentColor)
            .padding()
    }
}

struct EpisodeDescriptionView: View {
    var description: String
    
    var body: some View {
        ScrollView {
            Text(description.removingHTMLTags())
                .foregroundColor(Color.primaryWhite)
        }
        .padding()
    }
}
