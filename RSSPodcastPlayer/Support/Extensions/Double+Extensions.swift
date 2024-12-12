//
//  Double+Extensions.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 12/12/24.
//

extension Double {
    func toFormattedTime() -> String {
        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
