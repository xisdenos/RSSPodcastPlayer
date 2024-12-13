//
//  AudioPlayerError.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import Foundation

enum UserDefaultError: Error {
    case decodeError
    case urlCatchError
    case encodeError
}

extension UserDefaultError: LocalizedError {
    
    var description: String {
        switch self {
        case .decodeError:
            return "Failed to decode the model!"
        case .urlCatchError:
            return "failed to catch the URL"
        case .encodeError:
            return "Failed to encode the model"
        }
    }
}
