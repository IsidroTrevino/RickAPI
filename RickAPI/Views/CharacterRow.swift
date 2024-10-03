//
//  CharacterRow.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character

    var body: some View {
        HStack {
            NavigationLink(destination: CharacterDetail(character: character)){
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                } placeholder: {
                    ProgressView()
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                    
                    HStack {
                        Text(character.status)
                            .font(.subheadline)
                            .foregroundColor(character.status == "Alive" ? .green : .red)
                        
                        Text("•")
                        
                        Text(character.species)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Text("Location: \(character.location.name)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    CharacterRow(character: Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: Origin(name: "Earth (C-137)", url: ""),
        location: Location(name: "Citadel of Ricks", url: ""),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: []
    ))
}
