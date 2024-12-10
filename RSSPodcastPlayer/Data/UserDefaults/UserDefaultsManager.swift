//
//  UserDefaultsManager.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 10/12/24.
//

import Foundation

protocol UrlLoaderUserDefaultProtocol {
    func savePodcastUrl(url: URL, key: String)
    func retrievePodcastUrls(key: String) -> [String]
    func clearPodcastUrls(key: String)
}

class UserDefaultsManager: UrlLoaderUserDefaultProtocol {
    
    private var userDefaults = UserDefaults.standard
    
    func savePodcastUrl(url: URL, key: String) {
        var urlList = userDefaults.stringArray(forKey: key) ?? []
        
        if !urlList.contains(url.absoluteString) {
            urlList.append(url.absoluteString)
            userDefaults.set(urlList, forKey: key)
        }
        
        if let index = urlList.firstIndex(of: url.absoluteString) {
            urlList.remove(at: index)
        }
        
        urlList.insert(url.absoluteString, at: 0)
        userDefaults.set(urlList, forKey: key)
    }
    
    func retrievePodcastUrls(key: String) -> [String] {
        return userDefaults.stringArray(forKey: key) ?? []
    }
    
    func clearPodcastUrls(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
