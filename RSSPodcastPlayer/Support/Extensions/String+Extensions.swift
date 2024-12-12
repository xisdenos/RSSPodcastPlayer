//
//  ImageLoader.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 10/12/24.
//
import Foundation

extension String {
    
    func stringToURL() -> URL? {
            return URL(string: self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
}
