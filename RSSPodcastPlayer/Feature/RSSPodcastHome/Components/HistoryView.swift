//
//  HistoryView.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 10/12/24.
//
import SwiftUI

struct HistoryView: View {
    
    @StateObject var viewModel: RSSPodcastHomeViewModel
    
    var body: some View {
            Group {
                if viewModel.checkShowHistory() {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.urlStringList, id: \.self) { url in
                            Text(url)
                                .padding(5)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                                .onTapGesture {
                                    viewModel.url = url
                                    viewModel.showHistory = false
                                }
                        }
                    }
                    .padding(.top, 5)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                }
            }
        }
}
