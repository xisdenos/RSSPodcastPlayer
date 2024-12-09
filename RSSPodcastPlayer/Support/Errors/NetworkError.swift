//
//  NetworkError.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidStatusCode
    case networkError
    case badRequest
    case unauthorizedConnection
    case forbiddenRequest
    case unknownError
}

extension NetworkError: LocalizedError {
    
    var description: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "Data error"
        case .invalidStatusCode:
            return "Unknow status code"
        case .networkError:
            return "cannot establish network connection"
        case .badRequest:
            return "bad Request"
        case .unauthorizedConnection:
            return "Server not authorizing"
        case .forbiddenRequest:
            return "Forbidden request"
        case .unknownError:
            return "Unknown error"
        }
    }
}
