//
//  RSSPlayerViewFactory.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 12/12/24.
//

class RSSPlayerViewFactory {
    static func build(episode: Episode, podcast: Podcast) -> RSSPlayerView {
        let viewModel = RSSPlayerViewModel(podcast: podcast, episode: episode)
        let view = RSSPlayerView(viewModel: viewModel)
        return view
    }
}
