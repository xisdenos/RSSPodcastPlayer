//
//  RSSPodcastHomeViewModel.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 07/12/24.
//

import SwiftUI

class RSSPodcastHomeViewModel: ObservableObject {
    
    @Published var url: String = ""
    @Published var urlStringList = []
    @Published var showHistory = false
    
    let rssPodcastUseCase: RSSPodcastUseCaseProtocol
    let userDefaultsManager: UrlLoaderUserDefaultProtocol
    
    init(rssPodcastUseCase: RSSPodcastUseCaseProtocol = RSSPodcastUseCase(networkManager: NetworkManager(), decoder: XMLCoderAdapter()),
         userDefaultsManager: UrlLoaderUserDefaultProtocol) {
        self.rssPodcastUseCase = rssPodcastUseCase
        self.userDefaultsManager = userDefaultsManager
        loadParsedPodcast()
    }
    
    func checkShowHistory() -> Bool {
        return showHistory && !urlStringList.isEmpty
    }
    
    func retrieveSavedUrls() {
        urlStringList = userDefaultsManager.retrievePodcastUrls(key: "SavedUrls")
    }
    
    func loadParsedPodcast() {
        guard let urlPath = URL(string: url) else { return }
        rssPodcastUseCase.execute(url: urlPath) { podcast in
            self.userDefaultsManager.savePodcastUrl(url: urlPath, key: "SavedUrls")
            print(podcast.title)
            print(self.userDefaultsManager.retrievePodcastUrls(key: "SavedUrls"))
        } failure: { error in
            print(error)
        }

    }
}
