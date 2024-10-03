//
//  EpisodeRow.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

import SwiftUI

struct EpisodeRow: View {
    let episodeUrl: String

    var body: some View {
        Text("Episode \(episodeUrl.split(separator: "/").last ?? "Unknown")")
            .font(.headline)
            .padding()
    }
}

#Preview {
    EpisodeRow(episodeUrl: "https://rickandmortyapi.com/api/episode/1")
}
