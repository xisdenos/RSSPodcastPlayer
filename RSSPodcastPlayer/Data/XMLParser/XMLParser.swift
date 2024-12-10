//
//  XMLParser.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//
import Foundation
import XMLCoder

protocol XMLParserAdapterProtocol {
    func decodeXMLData<T: Decodable>(data: Data, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class XMLCoderAdapter: XMLParserAdapterProtocol {
    
    func decodeXMLData<T: Decodable>(data: Data, type: T.Type, completion: (Result<T, Error>) -> Void) {
        let decoder = XMLDecoder()
        decoder.dateDecodingStrategy = .formatted({
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
            return formatter
        }())
            
            do {
                let channel = try decoder.decode(T.self, from: data)
                completion(.success(channel))
            } catch {
                completion(.failure(error))
            }
    }
}
