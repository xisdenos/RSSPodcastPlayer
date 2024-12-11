//
//  Episode.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

struct Episode: Decodable, Identifiable {
    var id: UUID // Conforms to Identifiable
    let title: String
    let description: String
    let pubDate: Date
    let enclosure: Enclosure?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case pubDate
        case enclosure
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.pubDate = try container.decode(Date.self, forKey: .pubDate)
        self.enclosure = try container.decodeIfPresent(Enclosure.self, forKey: .enclosure)
    }
}
