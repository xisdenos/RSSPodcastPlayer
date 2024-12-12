//
//  AudioPlayerBox.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import SwiftUI
import Observation

struct AudioPlayerBox: View {
    
    @ObservedObject var viewModel: RSSPlayerViewModel
    
    var body: some View {
        VStack {
            
            if let totalTime = viewModel.episode.duration.toDouble() {
                Slider(value: $viewModel.currentTime, in: 0...totalTime)
            }
            
            HStack {
                Button(action: viewModel.returnAudio) {
                    Image(systemName: "backward.fill")
                }
                
                Button(action: {
                    viewModel.isPaused ? viewModel.pause() : viewModel.play()
                    viewModel.isPaused.toggle()
                }) {
                    Image(systemName: viewModel.isPaused ? "pause.fill" : "play.fill")
                }
                
                Button(action: viewModel.skipAudio) {
                    Image(systemName: "forward.fill")
                }
            }
        }
        .onDisappear {

        }
    }
}
