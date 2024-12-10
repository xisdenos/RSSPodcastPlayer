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
        let defaults = UserDefaults.standard
        return defaults.stringArray(forKey: key) ?? []
    }
}
