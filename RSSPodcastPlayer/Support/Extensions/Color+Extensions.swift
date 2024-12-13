//
//  Color+Hex.swift
//  RSSPodcastPlayer
//
//  Created by Lucas Pinto on 11/12/24.
//

import SwiftUI

extension Color {
    
    init(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        guard hexSanitized.count == 6 else {
            fatalError("Invalid hex string: \(hexString)")
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}

extension Color {
    public static var primaryBlue: Color {
        return Color.init(hexString: "#00264d")
    }
    
    public static var primaryWhite: Color {
        return Color.init(hexString: "#ffffff")
    }
    
    public static var accentColor: Color {
        return Color.init(hexString: "#f26419")
    }
    
    public static var primaryTextColor: Color {
        return Color.init(hexString: "#c0c0c0")
    }
}
