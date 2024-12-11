//
//  HistoryView.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 10/12/24.
//
import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var viewModel: RSSPodcastHomeViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Last Podcasts")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.top)
            
            VStack(spacing: 4) {
                ForEach(viewModel.urlStringList, id: \.self) { url in
                    Button(action: {
                        viewModel.url = url
                        viewModel.loadParsedPodcast()
                    }) {
                        HStack {
                            Image(systemName: "link.circle.fill")
                                .foregroundColor(.red)
                                .font(.title2)
                            
                            Text(url)
                                .font(.body)
                                .lineLimit(1)
                                .truncationMode(.middle)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                CustomButton(buttonText: "Apagar Historico", foregroundColor: Color.red) {
                    viewModel.clearSavedURls()
                }
            }
        }
        .background(Color.primaryBlue)
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
