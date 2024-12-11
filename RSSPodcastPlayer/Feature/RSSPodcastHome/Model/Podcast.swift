//
//  Podcast.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

struct Podcast: Decodable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let author: String
    let image: RSSImage
    let episodes: [Episode]

    enum CodingKeys: String, CodingKey {
        case channel
    }

    enum ChannelKeys: String, CodingKey {
        case id
        case title
        case author = "itunes:author"
        case image
        case description
        case episodes = "item"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let channel = try container.nestedContainer(keyedBy: ChannelKeys.self, forKey: .channel)

        self.id = UUID()
        self.title = try channel.decode(String.self, forKey: .title)
        self.description = try channel.decode(String.self, forKey: .description)
        self.author = try channel.decode(String.self, forKey: .author)
        self.image = try channel.decode(RSSImage.self, forKey: .image)
        self.episodes = try channel.decode([Episode].self, forKey: .episodes)
    }
    
    init(id: UUID = UUID(),
             title: String,
             description: String,
             author: String,
             image: RSSImage,
             episodes: [Episode]) {
            self.id = id
            self.title = title
            self.description = description
            self.author = author
            self.image = image
            self.episodes = episodes
        }
}
