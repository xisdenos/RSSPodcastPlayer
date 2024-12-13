//
//  CachedPodcast.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 13/12/24.
//

struct CachedPodcast: Codable, Hashable {
    var title: String
    var imageURL: String
    var url: String
}
