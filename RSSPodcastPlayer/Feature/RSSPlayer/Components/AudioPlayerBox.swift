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
        VStack(spacing: 16) {
            
            if let totalTime = viewModel.episode.duration.stringToSeconds() {
                
                HStack {
                    Text(viewModel.currentTime.toFormattedTime())
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Slider(value: $viewModel.currentTime, in: 0...totalTime, onEditingChanged: { _ in
                        viewModel.updateAudioTimeWithSliderBarValue(value: viewModel.currentTime)
                    })
                    .accentColor(.accentColor)
                    .padding([.leading, .trailing])
                    
                    Text(viewModel.episode.duration)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            HStack(spacing: 32) {
                
                Button(action: viewModel.returnAudio) {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.primary)
                }
                
                Button(action: {
                    viewModel.isPaused ? viewModel.pause() : viewModel.play()
                    viewModel.isPaused.toggle()
                }) {
                    Image(systemName: viewModel.isPaused ? "pause.fill" : "play.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.primary)
                }
                
                Button(action: viewModel.skipAudio) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.primary)
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}
