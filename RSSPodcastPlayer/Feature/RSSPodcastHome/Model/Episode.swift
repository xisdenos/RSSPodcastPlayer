//
//  Episode.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

struct Episode: Decodable, Identifiable {
    
    var id: UUID
    let title: String
    let description: String
    let pubDate: Date
    let duration: String
    let enclosure: Enclosure?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case pubDate
        case duration = "itunes:duration"
        case enclosure
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.pubDate = try container.decode(Date.self, forKey: .pubDate)
        self.duration = try container.decode(String.self, forKey: .duration)
        self.enclosure = try container.decodeIfPresent(Enclosure.self, forKey: .enclosure)
    }
    
    init(id: UUID = UUID(),
             title: String,
             description: String,
             pubDate: Date,
             enclosure: Enclosure? = nil,
             duration: String) {
            self.id = id
            self.title = title
            self.description = description
            self.pubDate = pubDate
            self.enclosure = enclosure
            self.duration = duration
        }
}

extension Episode: Equatable {
    
    static func == (lhs: Episode, rhs: Episode) -> Bool {
            return lhs.id == rhs.id &&
                   lhs.title == rhs.title
        }
}
