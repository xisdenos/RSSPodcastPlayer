//
//  ContentView.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 07/12/24.
//

import SwiftUI

struct RSSPodcastHomeView: View {
    
    @StateObject var viewModel = RSSHomeViewModelFactory.build()

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        Text("RSS Podcast Player")
                            .font(.largeTitle)
                            .foregroundColor(Color.accentColor)
                            .padding()
                        
                        HStack {
                            searchBar
                            searchButton
                        }
                        .padding(.horizontal)
                        
                        if !viewModel.urlStringList.isEmpty {
                            HistoryView(viewModel: viewModel)
                        }
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                                .padding()
                        }
                        
                        LoadedPodcastView(podcast: $viewModel.podCast)
                        
                    }
                    .padding()
                }
            }
            .background(Color.primaryBlue)
            
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
        .navigationBarHidden(true)
    }
}

// MARK: - Private components

extension RSSPodcastHomeView {
    private var searchBar: some View {
        TextField("Search your Podcast", text: $viewModel.url)
            .foregroundColor(.black)
            .padding()
            .background(Color.gray.opacity(0.8))
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 1))
            .overlay(alignment: .trailing) {
                if !viewModel.url.isEmpty {
                    Button(action: {
                        viewModel.url = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                    .padding(.trailing, 8)
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
                       .foregroundColor(.gray)
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
