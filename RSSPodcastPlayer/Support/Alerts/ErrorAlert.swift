//
//  ErrorAlert.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 10/12/24.
//

import SwiftUI

struct GenericErrorAlert: View {
    @State private var showError: Bool = true
    var errorMessage: String
    
    var body: some View {
        VStack {}
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            showError = true
        }
    }
}
