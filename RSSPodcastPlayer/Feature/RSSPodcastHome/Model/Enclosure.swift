//
//  Enclosure.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

struct Enclosure: Decodable {
    let url: URL
    let length: Int
    let type: String
}
