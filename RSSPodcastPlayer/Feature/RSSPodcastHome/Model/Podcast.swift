//
//  Podcast.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

struct Podcast: Decodable {
    var title: String
    var language: String
    var copyright: String
    var description: String
    var author: String?
    var explicit: Bool
    var imageURL: String?
    var episodes: [Episode]
    
    enum CodingKeys: String, CodingKey {
        case title
        case language
        case copyright
        case description
        case author = "itunes:author"
        case explicit = "itunes:explicit"
        case imageURL = "itunes:image"
        case episodes = "item"
    }
}
