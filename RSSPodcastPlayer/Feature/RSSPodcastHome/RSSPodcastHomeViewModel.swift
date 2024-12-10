//
//  RSSPodcastHomeViewModel.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 07/12/24.
//

import SwiftUI

class RSSPodcastHomeViewModel: ObservableObject {
    
    @Published var url: String = ""
    let rssPodcastUseCase: RSSPodcastUseCaseProtocol
    
    init(rssPodcastUseCase: RSSPodcastUseCaseProtocol = RSSPodcastUseCase(networkManager: NetworkManager())) {
        self.rssPodcastUseCase = rssPodcastUseCase
        loadData()
    }
    
    func loadData() {
        guard let urlPath =  URL(string: "https://feeds.megaphone.fm/la-cotorrisa") else { return }
        rssPodcastUseCase.execute(url: urlPath) { podcast in
            print("Foi")
        } failure: { error in
            print("Não foi")
        }

    }
}
