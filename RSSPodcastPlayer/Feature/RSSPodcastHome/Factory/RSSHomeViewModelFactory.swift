//
//  RSSHomeViewModelFactory.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import Foundation

class RSSHomeViewModelFactory {
    static func build() -> RSSPodcastHomeViewModel {
        let userDefaultsManager: UrlLoaderUserDefaultProtocol = UserDefaultsManager()
        let rssPodcastUseCase: RSSPodcastUseCaseProtocol = RSSPodcastUseCase(networkManager: NetworkManager(), decoder: XMLCoderAdapter())
        let viewModel = RSSPodcastHomeViewModel(rssPodcastUseCase: rssPodcastUseCase, userDefaultsManager: userDefaultsManager)
        return viewModel
    }
}
