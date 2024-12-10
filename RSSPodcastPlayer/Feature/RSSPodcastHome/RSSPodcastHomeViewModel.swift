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
    
    init(rssPodcastUseCase: RSSPodcastUseCaseProtocol = RSSPodcastUseCase(networkManager: NetworkManager(), decoder: XMLCoderAdapter())) {
        self.rssPodcastUseCase = rssPodcastUseCase
        loadParsedPodcast()
    }
    
    func save
    
    func loadParsedPodcast() {
        guard let urlPath = URL(string: url) else { return }
        rssPodcastUseCase.execute(url: urlPath) { podcast in
            print(podcast.title)
        } failure: { error in
            print(error)
        }

    }
}
