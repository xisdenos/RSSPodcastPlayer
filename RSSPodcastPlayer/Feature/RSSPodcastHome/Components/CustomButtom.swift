//
//  CustomButtom.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 10/12/24.
//

import SwiftUI

struct CustomButton: View {
    var buttonText: String
    var foregroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .fontWeight(.semibold)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(10)
        }
    }
}
