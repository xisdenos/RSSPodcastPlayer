//
//  Episode.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

struct Episode: Decodable {
    var title: String
    var description: String
    var pubDate: String
    var duration: Int?
    var audioURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case pubDate
        case duration = "itunes:duration"
        case audioURL = "enclosure"
    }
}
