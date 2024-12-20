//
//  UrlClient.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

protocol GetUrlRequestManagerProtocol {
    func getUrlData(with request: NetworkRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class NetworkManager: GetUrlRequestManagerProtocol {
    
    func getUrlData(with request: NetworkRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        var urlRequest: URLRequest = URLRequest(url: request.endpointURL)
        urlRequest.httpMethod = request.method.rawValue.uppercased()
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.unknownError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidStatusCode))
                return
            }
            
            // MARK: - status code error handler
            
            switch response.statusCode {
            case 200...299:
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                completion(.success(data))
            case 401:
                completion(.failure(NetworkError.unauthorizedConnection))
            case 403:
                completion(.failure(NetworkError.forbiddenRequest))
            case 400...499:
                completion(.failure(NetworkError.badRequest))
            case 500...599:
                completion(.failure(NetworkError.networkError))
            case -1002:
                completion(.failure(NetworkError.unsupportedURL))
            default:
                completion(.failure(NetworkError.unknownError))
            
            }
        }.resume()
    }
}
