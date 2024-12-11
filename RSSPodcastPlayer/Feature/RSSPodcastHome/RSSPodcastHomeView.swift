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
                    
                    HStack {
                        searchBar
                        searchButton
                    }
                    .padding()
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .green))
                            .padding()
                    }
                    
                    LoadedPodcastView(podcast: $viewModel.podCast)
                    
                    if !viewModel.urlStringList.isEmpty {
                        HistoryView(viewModel: viewModel)
                        
                        CustomButton(buttonText: "Apagar Historico", foregroundColor: Color.red) {
                            viewModel.clearSavedURls()
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color.blue)
        
        // MARK: - Alert
        
        .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? ""),
                dismissButton: .default(Text("OK")) {
                    viewModel.errorMessage = nil
                }
            )
        }

    }
}

// MARK: - Private components

extension RSSPodcastHomeView {
    private var searchBar: some View {
        TextField("Search your Podcast", text: $viewModel.url)
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 1))
            .overlay(alignment: .trailing) {  // Align the button to the trailing edge
                if !viewModel.url.isEmpty {
                    Button(action: {
                        viewModel.url = ""  // Clears the text field
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8) // Add padding to avoid overlapping
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.url)
            .autocapitalization(.none)
            .keyboardType(.webSearch)
    }
    
    private var searchButton: some View {
        Button(action: {
                   viewModel.loadParsedPodcast()
               }) {
                   Image(systemName: "magnifyingglass")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 20, height: 20)
                       .foregroundColor(.gray) // Change color as needed
               }
               .buttonStyle(PlainButtonStyle())
               .padding()
               .background(Color.white)
               .clipShape(.buttonBorder)
               .shadow(radius: 5)
               .buttonStyle(PlainButtonStyle())
    }
}
#Preview {
    RSSPodcastHomeView()
}
