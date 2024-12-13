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
    
    func stringToDoubleOrSeconds() -> Double? {
        let components = self.split(separator: ":")
        if components.count == 3,
           let hours = Double(components[0]),
           let minutes = Double(components[1]),
           let seconds = Double(components[2]) {
            return (hours * 3600) + (minutes * 60) + seconds
        }
        return Double(self)
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
    
    func toFormattedTime() -> String? {
            guard let timeInSeconds = Double(self) else { return nil }
            let hours = Int(timeInSeconds) / 3600
            let minutes = (Int(timeInSeconds) % 3600) / 60
            let seconds = Int(timeInSeconds) % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
}
