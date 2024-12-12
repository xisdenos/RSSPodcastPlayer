//
//  AudioPlayerError.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import Foundation

enum AudioPlayerError: Error {
    case noNextTrack
    case noPreviousTrack
    case invalidTrackURL
}

extension AudioPlayerError: LocalizedError {
    
    var description: String {
        switch self {
        case .noNextTrack:
            return "There is no next track!"
        case .noPreviousTrack:
            return "There is no previous track!"
        case .invalidTrackURL:
            return "Invalid track URL!"
        }
    }
}
