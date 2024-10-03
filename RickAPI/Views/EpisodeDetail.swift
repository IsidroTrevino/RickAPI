//
//  EpisodeDetail.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

import SwiftUI

struct EpisodeDetail: View {
    let episodeUrl: String
    @StateObject private var viewModel = EpisodeViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Episode Details...")
            } else if let episode = viewModel.episode {
                Text(episode.name)
                    .font(.largeTitle)
                    .bold()

                Text("Air Date: \(episode.airDate)")
                    .font(.headline)
                    .padding(.top, 10)

                Text("Season and Episode Number: \(episode.episodeCode)")
                    .font(.subheadline)
                    .padding(.top, 10)
            } else {
                Text("Failed to load episode details.")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .task {
            do {
                try await viewModel.getEpisodeInfo(from: episodeUrl)
            } catch {
                print("paso algo")
            }
        }
    }
}

#Preview {
    EpisodeDetail(episodeUrl: "https://rickandmortyapi.com/api/episode/1")
}
