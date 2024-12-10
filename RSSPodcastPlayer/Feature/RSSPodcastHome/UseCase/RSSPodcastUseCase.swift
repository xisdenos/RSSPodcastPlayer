//
//  RSSPodcastUseCase.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//
import Foundation

protocol RSSPodcastUseCaseProtocol {
    typealias Success = ((Podcast) -> Void)
    typealias Failure = ((Error) -> Void)
    func execute(url: URL, success: @escaping Success, failure: @escaping Failure)
}

class RSSPodcastUseCase: RSSPodcastUseCaseProtocol {
    
    private let networkManager: GetUrlRequestManagerProtocol
    
    init(networkManager: GetUrlRequestManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func execute(url: URL, success: @escaping Success, failure: @escaping Failure) {
        let request = NetworkRequest(endpointURL: url, method: HTTPMethod.get)
        networkManager.getUrlData(with: request) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
