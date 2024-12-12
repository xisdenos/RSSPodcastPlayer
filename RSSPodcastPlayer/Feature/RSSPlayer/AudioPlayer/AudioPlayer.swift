//
//  AudioPlayer.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import SwiftUI
import Combine
import AVFoundation

protocol AudioPlayerProtocol {
    func play(url: URL?)
    func changeAudio(url: URL?)
    func pause()
}

class AudioPlayer: NSObject, AudioPlayerProtocol, ObservableObject {
    
    // MARK: Private variables
    
    private var player: AVPlayer
    private var currentEpisode: Episode
    private var timeObserver: Any?
    
    // MARK: Public variables
    
    @Published var currentTime: TimeInterval = 0
    @Published var isPaused: Bool = false
    
    // MARK: Init

    init(currentEpisode: Episode) {
        self.currentEpisode = currentEpisode
        self.player = AVPlayer()
    }
    
    deinit {
        removeAVPlayerEntities()
    }
    
    // MARK: Private funcs
    
    func removeAVPlayerEntities() {
        player.pause()
        player.replaceCurrentItem(with: nil)
        isPaused = true
        currentTime = 0
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
        }
    }
    
    private func observePlayerEvents() {
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 600), queue: .main) { [weak self] time in
            self?.currentTime = CMTimeGetSeconds(time)
        }
    }
    
    private func setupPlayerPreferences(player: AVPlayer) {
        player.allowsExternalPlayback = true
        player.appliesMediaSelectionCriteriaAutomatically = true
        player.automaticallyWaitsToMinimizeStalling = true
        player.volume = 1.0
    }
    
    // MARK: Public funcs

    func play(url: URL?) {
        guard let url else {
//            errorCaller(error: AudioPlayerError.invalidTrackURL)
            return
        }
        
        if player.currentItem == nil {
            player = AVPlayer(playerItem: AVPlayerItem(url: url))
            setupPlayerPreferences(player: player)
            observePlayerEvents()
        }
        if player.currentItem != nil && !isPaused {
            player.replaceCurrentItem(with: AVPlayerItem(url: url))
        }
        
        player.play()
    }

    func pause() {
        player.pause()
        isPaused = true
    }
    
    func changeAudio(url: URL?) {
        removeAVPlayerEntities()
        play(url: url)
    }
}

//// MARK: Delegate extension
//
//extension AudioPlayer: AVAudioPlayerDelegate {
//    func audioPlayerDidChangePosition(_ player: AVAudioPlayer) {
//        currentTime = player.currentTime
//    }
//}
