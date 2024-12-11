//
//  AsyncImageGetter.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import SwiftUI

struct AsyncImageGetter: View {
    
    var url: URL?
    
    var body: some View {
        AsyncImage(url: url) { image in
            switch image {
            case .empty:
                EmptyView()
            case .success(let image):
                image.resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            case .failure(let error):
                Text("Failed to load image")
            @unknown default:
                EmptyView()
            }
        }
    }
}
