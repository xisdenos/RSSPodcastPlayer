//
//  RSSPodcastHomeViewModel.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 07/12/24.
//

import SwiftUI

class RSSPodcastHomeViewModel: ObservableObject {
    
    @Published var url: String = ""
    @Published var urlStringList: [String] = []
    @Published var showHistory = false
    @Published var isLoading = false
    @Published var podCast: Podcast?
    @Published var errorMessage: String?
    
    let rssPodcastUseCase: RSSPodcastUseCaseProtocol
    let userDefaultsManager: UrlLoaderUserDefaultProtocol
    
    init(rssPodcastUseCase: RSSPodcastUseCaseProtocol = RSSPodcastUseCase(networkManager: NetworkManager(), decoder: XMLCoderAdapter()),
         userDefaultsManager: UrlLoaderUserDefaultProtocol) {
        self.rssPodcastUseCase = rssPodcastUseCase
        self.userDefaultsManager = userDefaultsManager
        retrieveSavedUrls()
    }
    
    func clearErrorMessage() {
        errorMessage = nil
    }
    
    func checkShowHistory() -> Bool {
        return showHistory && !urlStringList.isEmpty
    }
    
    func retrieveSavedUrls() {
        urlStringList = userDefaultsManager.retrievePodcastUrls(key: "SavedUrls")
    }
    
    func clearSavedURls() {
        userDefaultsManager.clearPodcastUrls(key: "SavedUrls")
        urlStringList.removeAll()
    }
    
    func loadParsedPodcast() {
        isLoading = true
        guard let urlPath = URL(string: url) else { return }
        rssPodcastUseCase.execute(url: urlPath) { podcast in
            self.userDefaultsManager.savePodcastUrl(url: urlPath, key: "SavedUrls")
            DispatchQueue.main.async {
                self.isLoading = false
                self.podCast = podcast
                self.retrieveSavedUrls()
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = error
            }
        }

    }
}
