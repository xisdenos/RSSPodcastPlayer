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
    func saveCachedPodcast(key: String, podcast: CachedPodcast)
    func fetchCachedPodcasts(key: String) -> [CachedPodcast]
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

extension UserDefaultsManager {
    
    func saveCachedPodcast(key: String, podcast: CachedPodcast) {
        do {
            let data = try JSONEncoder().encode(podcast)
            userDefaults.set(data, forKey: podcast.url)

            if var urls = userDefaults.stringArray(forKey: key) {
                if !urls.contains(podcast.url) {
                    urls.append(podcast.url)
                    userDefaults.setValue(urls, forKey: key)
                }
            } else {
                userDefaults.setValue([podcast.url], forKey: key)
            }
        } catch {
            print("Failed to encode podcast: \(error)")
        }
    }
    func fetchCachedPodcasts(key: String) -> [CachedPodcast] {
        var podcasts: [CachedPodcast] = []

        guard let urls = userDefaults.stringArray(forKey: key) else { return [] }
        
        urls.forEach { url in
            if let data = userDefaults.object(forKey: url) as? Data {
                do {
                    if let podcast = try? JSONDecoder().decode(CachedPodcast.self, from: data) {
                        podcasts.append(podcast)
                    }
                } catch {
                    print("Failed to decode podcast for URL \(url): \(error)")
                }
            }
        }

        return podcasts
    }

}
