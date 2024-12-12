//
//  AudioPlayer.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import Foundation
import AVFoundation

protocol AudioPlayerProtocol {
    func play(url: URL?) -> AudioPlayerError?
    func pause()
    func next() -> AudioPlayerError?
    func previous() -> AudioPlayerError?
}

class AudioPlayer: ObservableObject, AudioPlayerProtocol {
    private var player: AVPlayer
    private var audioSourcePodcast: Podcast
    private var currentEpisode: Episode

    init(audioSourcePodcast: Podcast, currentEpisode: Episode) {
        self.audioSourcePodcast = audioSourcePodcast
        self.currentEpisode = currentEpisode
        self.player = AVPlayer()
    }
    
    private func findEpisodeIndex() -> Int {
        guard let index = audioSourcePodcast.episodes.firstIndex(of: currentEpisode) else { return 0 }
        return index
    }

    func play(url: URL?) -> AudioPlayerError? {
        guard let url else { return .invalidTrackURL }
        let player = AVPlayer(url: url)
        player.play()
        return nil
    }

    func pause() {
        player.pause()
    }

    func next() -> AudioPlayerError? {
        let nextIndex = findEpisodeIndex() + 1
        guard nextIndex < audioSourcePodcast.episodes.count else { return .noNextTrack }
        let nextEpisodeURL = audioSourcePodcast.episodes[nextIndex].enclosure?.url
        play(url: nextEpisodeURL)
        return nil
    }

    func previous() -> AudioPlayerError? {
        let previousIndex = findEpisodeIndex() - 1
        guard previousIndex >= 0 else { return .noPreviousTrack }
        let previousEpisodeURL = audioSourcePodcast.episodes[previousIndex].enclosure?.url
        play(url: previousEpisodeURL)
        return nil
    }
}
