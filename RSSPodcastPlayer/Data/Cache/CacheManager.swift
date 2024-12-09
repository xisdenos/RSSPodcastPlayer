//
//  CacheManager.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

protocol AnyObjectCacheManagerProtocol {
    func setAnyObject(_ object: AnyObject, forKey key: String)
    func getAnyObject(forKey key: String) -> AnyObject?
}

final class CacheManager: AnyObjectCacheManagerProtocol {
    
    //MARK: - Private constants
    
    static let shared = CacheManager()
    private let cacheManagerValidator = CacheManagerValidator()
    private let fileManager: FileManager
    private let cacheDirectoryURL: URL
    private let cache = NSCache<NSString, AnyObject>()
    
    //MARK: - Init
    
    private init?(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        
        guard let cacheDirectory else { return nil }
        self.cacheDirectoryURL = cacheDirectory.appendingPathComponent("CustomCache", isDirectory: true)
        
        if cacheManagerValidator.checkDirectoryNotExists(url: self.cacheDirectoryURL) {
            createDirectoryIfNotExists(url: cacheDirectoryURL)
        }
    }
    
    //MARK: - Private funcs
    
    private func createDirectoryIfNotExists(url: URL) {
        try? fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
    }
    
    //MARK: - Singleton public funcs
    
    func setAnyObject(_ object: AnyObject, forKey key: String) {
        cache.setObject(object, forKey: NSString(string: key))
    }
    
    func getAnyObject(forKey key: String) -> AnyObject? {
        return cache.object(forKey: NSString(string: key))
    }
}
