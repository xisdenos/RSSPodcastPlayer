//
//  Episode.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

struct Episode: Codable {
    let title: String
    let description: String
    let pubDate: Date
    let duration: String
    let publishDate: String
}
