//
//  CharacterDetail.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

import SwiftUI

struct CharacterDetail: View {
    let character: Character

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                let yOffset = geometry.frame(in: .global).minY

                Image("RickAndMorty")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: max(300, 300 + yOffset))
                    .clipped()
                    .offset(y: yOffset > 0 ? -yOffset : 0)
                    .scaleEffect(yOffset > 0 ? 1 + yOffset / 100000 : 1)
            }
            .frame(height: 300)

            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .offset(y: -100)
                    .padding(.bottom, -120)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .center) {
                Text(character.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                HStack {
                    Text(character.status)
                        .font(.title2)
                        .foregroundColor(character.status == "Alive" ? .green : .red)
                    
                    Text("•")
                    
                    Text(character.species)
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Gender: \(character.gender)")
                            .font(.title2)
                        Spacer()
                    }
                    if character.type.count != 0 {
                        HStack {
                            Text("Species type: \(character.type)")
                                .font(.title2)
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Text("Origin: \(character.origin.name)")
                            .font(.title2)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Location: \(character.location.name)")
                            .font(.title2)
                        Spacer()
                    }
                }
                .padding(.top, 10)

                Text("Episodes where \(character.name.split(separator: " ")[0]) appears: ")
                    .font(.title2)
                    .bold()
                    .padding(.top, 20)

                    ForEach(character.episode, id: \.self) { episodeUrl in
                        NavigationLink(destination: EpisodeDetail(episodeUrl: episodeUrl)) {
                            HStack {
                                EpisodeRow(episodeUrl: episodeUrl)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        Divider()
                    }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    NavigationView {
        CharacterDetail(character: Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: Origin(name: "Earth (C-137)", url: ""),
            location: Location(name: "Citadel of Ricks", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"
            ]
        ))
    }
}
