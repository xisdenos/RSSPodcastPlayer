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
    
    func stringToSeconds() -> Double? {
        let components = self.split(separator: ":")
        guard components.count == 3,
              let hours = Double(components[0]),
              let minutes = Double(components[1]),
              let seconds = Double(components[2]) else {
            return nil
        }
        
        return (hours * 3600) + (minutes * 60) + seconds
    }
    
    func removingHTMLTags() -> String {
       do {
           let regex = try NSRegularExpression(pattern: "<.*?>", options: [])
           let range = NSRange(location: 0, length: self.utf16.count)
           return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
       } catch {
           return self
       }
   }
}
