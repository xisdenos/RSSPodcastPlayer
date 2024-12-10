//
//  ContentView.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 07/12/24.
//

import SwiftUI

struct RSSPodcastHomeView: View {
    
    @StateObject var viewModel = RSSPodcastHomeViewModel(userDefaultsManager: UserDefaultsManager())

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text("RSS Podcast Player")
                        .font(.largeTitle)
                        .padding()

                    searchBar
                    CustomButton(buttonText: "Load Podcast", foregroundColor: Color.green) {
                        viewModel.loadParsedPodcast()
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .green))
                            .padding()
                    }
                    
                    LoadedPodcastView(viewModel: viewModel)
                    
                    if !viewModel.urlStringList.isEmpty {
                        HistoryView(viewModel: viewModel)
                        
                        CustomButton(buttonText: "Apagar Historico", foregroundColor: Color.red) {
                            viewModel.clearSavedURls()
                        }
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
        }.background(Color.blue)
    }
    
    private var searchBar: some View {
        TextField("Search your Podcast", text: $viewModel.url)
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 1))
    }
}

#Preview {
    RSSPodcastHomeView()
}
