//
//  CacheManagerValidator.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 09/12/24.
//

import Foundation

class CacheManagerValidator {
    
    private let fileManager: FileManager
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    func checkDirectoryNotExists(url: URL) -> Bool {
        return !fileManager.fileExists(atPath: url.path)
    }
}
