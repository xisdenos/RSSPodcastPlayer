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
    @State private var currentTime = 0.0
    @State private var totalTime = 0.0
    
    var body: some View {
        VStack {
            
            // change to viewModel.audio.currentTime
            Slider(value: $currentTime, in: 0...totalTime)
            
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
    }
}
