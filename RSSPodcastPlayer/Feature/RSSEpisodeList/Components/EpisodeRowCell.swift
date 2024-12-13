//
//  EpisodeRowCell.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//
import SwiftUI

struct EpisodeRowCell: View {
    var episode: Episode

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(episode.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            HStack {
                Text("Publication date:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(episode.pubDate.toString())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text(episode.duration.toFormattedTime() ?? episode.duration)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    EpisodeRowCell(episode: Episode(
        id: UUID(),
        title: "Introduction to Swift 6",
        description: "An overview of the exciting new features coming to Swift 6.",
        pubDate: Date(),
        enclosure: Enclosure(url: URL("https://example.com/episode1.mp3")!, length: 60, type: "audio/mpeg"),
        duration: "3000"
    ))
    
    EpisodeRowCell(episode: Episode(
        id: UUID(),
        title: "Introduction to Swift 6",
        description: "An overview of the exciting new features coming to Swift 6.",
        pubDate: Date(),
        enclosure: Enclosure(url: URL("https://example.com/episode1.mp3")!, length: 60, type: "audio/mpeg"),
        duration: "3000"
    ))
}
