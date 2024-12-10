//
//  ContentView.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 07/12/24.
//

import SwiftUI

struct RSSPodcastHomeView: View {
    
    @StateObject var viewModel = RSSPodcastHomeViewModel(userDefaultsManager: UserDefaultsManager())
    @State private var isLoading = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text("RSS Podcast Player")
                        .font(.largeTitle)
                        .padding()

                    searchBar
                    HistoryView()
                        .environment(viewModel)
                    loadButton
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .green))
                            .padding()
                    }

                    // Display error message if any
//                    if let errorMessage = viewModel.$errorMessage {
//                        Text(errorMessage)
//                            .foregroundColor(.red)
//                            .font(.subheadline)
//                            .padding()
//                    }
                }
                .padding()
            }
        }
    }
    
    // Extracted search bar view
    private var searchBar: some View {
        TextField("Search your Podcast", text: $viewModel.url)
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 1))
            .onTapGesture {
                self.viewModel.showHistory.toggle()
            }
    }
    
    // Extracted history list view
    
    // Extracted load button view
    private var loadButton: some View {
        Button("Load Podcast") {
            isLoading = true
            viewModel.loadParsedPodcast {
                isLoading = false
            }
        }
        .fontWeight(.semibold)
        .foregroundColor(.green)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .disabled(isLoading)
    }
}

#Preview {
    RSSPodcastHomeView()
}
