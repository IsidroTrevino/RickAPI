//
//  SearchBar.swift
//  RickAPI
//
//  Created by Isidro Treviño on 02/10/24.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search characters", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
        .padding()
        .cornerRadius(10)
    }
}
