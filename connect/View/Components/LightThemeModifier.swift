//
//  LightThemeModifier.swift
//  connect
//
//  Created by Рауан Аблайхан on 10.01.2024.
//

import Foundation
import SwiftUI

struct LightThemeModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .background(colorScheme == .dark ? Color.black : Color.white)
    }
}

extension View {
    func lightTheme() -> some View {
        self.modifier(LightThemeModifier())
    }
}
