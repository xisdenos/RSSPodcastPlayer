//
//  RSSPlayerViewModel.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import Foundation
import Combine

class RSSPlayerViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var audioPlayer: AudioPlayer
    @Published var podcast: Podcast
    @Published var episode: Episode
    @Published var isPaused: Bool = true
    @Published var currentTime: Double = 0
    @Published var audioErrorFeedbackMessage: String?
    
    init(podcast: Podcast, episode: Episode) {
        self.podcast = podcast
        self.episode = episode
        self.audioPlayer = AudioPlayer(currentEpisode: episode)
        
        audioPlayer.$isPaused
            .sink { [weak self] isPaused in
                self?.isPaused = isPaused
            }
            .store(in: &cancellables)
        
        audioPlayer.$currentTime
            .sink { [weak self] currentTime in
                self?.currentTime = currentTime
            }
            .store(in: &cancellables)
    }
    
    func removeAudio() {
        audioPlayer.removeAVPlayerEntities()
    }
    
    private func errorCaller(error: AudioPlayerError) {
        audioErrorFeedbackMessage = error.description
    }
    
    private func findEpisodeIndex() -> Int {
        guard let index = podcast.episodes.firstIndex(of: episode) else { return 0 }
        return index
    }
    
    private func changeEpisode(episode: Episode) {
        self.episode = episode
    }
    
    func play() {
        audioPlayer.play(url: episode.enclosure?.url)
    }
    
    func pause() {
        audioPlayer.pause()
    }
    
    func skipAudio() {
        let nextIndex = findEpisodeIndex() + 1
        guard nextIndex < podcast.episodes.count else {
            errorCaller(error: AudioPlayerError.noNextTrack)
            return
        }
        let nextEpisodeURL = podcast.episodes[nextIndex].enclosure?.url
        episode = podcast.episodes[nextIndex]
        audioPlayer.changeAudio(url: episode.enclosure?.url)
    }
    
    func returnAudio() {
        let previousIndex = findEpisodeIndex() - 1
        guard previousIndex >= 0 else {
            errorCaller(error: AudioPlayerError.noPreviousTrack)
            return
        }
        let previousEpisodeURL = podcast.episodes[previousIndex].enclosure?.url
        episode = podcast.episodes[previousIndex]
        audioPlayer.changeAudio(url: episode.enclosure?.url)
    }
    
    func updateAudioTimeWithSliderBarValue(value: Double) {
        audioPlayer.updateAudioTime(currentTime: value)
    }
}
