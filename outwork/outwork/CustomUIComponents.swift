//
//  CustomUIComponents.swift
//  outwork
//
//  Created by Erik Miller on 10/26/20.
//

import SwiftUI

enum ColorPalette {
    case secondary

    var color: Color {
        switch self {
        case .secondary: return Color.pink

        }
    }
}



struct SecondaryButtonStyle: ButtonStyle {
    var color: Color = .pink
    func makeBody(configuration: Configuration) -> some View {
        SecondaryButton(configuration: configuration, color: color)
    }
}

struct SecondaryButton: View {
    let configuration: SecondaryButtonStyle.Configuration
    let color: Color
    var body: some View {
        return configuration.label
        .foregroundColor(Color.white)
    }
}


enum ButtonStylePalette: ButtonStyle {
    case secondary
    
    func makeBody(configuration: Configuration) -> some View {
        switch self {
        case .secondary:
            return AnyView(SecondaryButtonStyle(color: ColorPalette.secondary.color)
                        .makeBody(configuration: configuration))
            // Return button styled view for secondary case
        //case .destructive:
            // Return button styled view for destructive case
        }
    }
}
