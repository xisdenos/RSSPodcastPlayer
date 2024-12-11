//
//  RSSPodcastUseCase.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//
import Foundation

protocol RSSPodcastUseCaseProtocol {
    typealias Success = ((Podcast) -> Void)
    typealias Failure = ((String) -> Void)
    func execute(url: URL, success: @escaping Success, failure: @escaping Failure)
}

class RSSPodcastUseCase: RSSPodcastUseCaseProtocol {
    
    private let networkManager: GetUrlRequestManagerProtocol
    private let decoder: XMLParserAdapterProtocol
    
    init(networkManager: GetUrlRequestManagerProtocol, decoder: XMLParserAdapterProtocol) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func execute(url: URL, success: @escaping Success, failure: @escaping Failure) {
        let request = NetworkRequest(endpointURL: url, method: HTTPMethod.get)
        networkManager.getUrlData(with: request) { result in
            switch result {
            case .success(let data):
                self.decoder.decodeXMLData(data: data, type: Podcast.self) { result in
                    switch result {
                    case .success(let podcast):
                        success(podcast)
                    case .failure(let error):
                        failure(error.localizedDescription)
                    }
                }
            case .failure(let error):
                failure(error.description)
            }
        }
    }
}
