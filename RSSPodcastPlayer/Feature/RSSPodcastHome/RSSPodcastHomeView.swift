//
//  ContentView.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 07/12/24.
//

import SwiftUI

struct RSSPodcastHomeView: View {
    
    @StateObject var viewModel = RSSPodcastHomeViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text("RSS Podcast Player")
                        .font(.largeTitle)
                        .padding()

                    VStack(spacing: 20) {
                        TextField("Search your Podcast", text: $viewModel.url)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 1))
                        
                        Button("Load Podcast") {
                            print("apertado")
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    RSSPodcastHomeView()
}
