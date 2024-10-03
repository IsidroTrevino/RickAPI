//
//  Settings.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

import SwiftUI

struct Settings: View {
    @Binding var isDarkMode: Bool
    @AppStorage("invertColors") private var invertColors: Bool = false


    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $isDarkMode) {
                    Label("Dark Mode", systemImage: isDarkMode ? "moon.fill" : "sun.max.fill")
                }
                .animation(.interpolatingSpring(duration: 0.3), value: isDarkMode)
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Settings(isDarkMode: .constant(false))
}
