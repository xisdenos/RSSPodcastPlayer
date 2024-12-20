//
//  NetworkRequest.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

struct NetworkRequest {
    var endpointURL: URL
    var method: HTTPMethod
}

enum HTTPMethod: String {
    case get
}
