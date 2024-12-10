//
//  Episode.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

struct Episode: Decodable {
    let title: String
    let description: String
    let pubDate: Date
    let enclosure: Enclosure?
}
