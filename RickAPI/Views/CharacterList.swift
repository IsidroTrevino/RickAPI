//
//  CharacterList.swift
//  RickAPI
//
//  Created by Isidro Treviño on 01/10/24.
//

import SwiftUI

struct CharacterList: View {
    @StateObject private var charVM = CharacterViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var hasError: Bool = false
    @State private var isLoading: Bool = true
    @State private var rotationAngle: Double = 360
    @State private var searchText: String = ""

    var filteredCharacters: [Character] {
        if searchText.isEmpty {
            return charVM.characters
        } else {
            return charVM.characters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    if isLoading {
                        ProgressView("Loading Characters...")
                            .padding()
                            .transition(.opacity)
                    } else if hasError {
                        VStack {
                            Image("sad")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                            Text("Error 400: Bad Request")
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding()
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    rotationAngle -= 360
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    loadData()
                                }
                            }) {
                                HStack {
                                    Image(systemName: "arrow.counterclockwise")
                                        .rotationEffect(.degrees(rotationAngle))
                                        .animation(.easeInOut(duration: 0.6), value: rotationAngle)
                                    
                                    Text("Retry")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                        .scaleEffect(1.1)
                                        .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5))
                                }
                            }
                        }
                    } else {
                        SearchBar(text: $searchText)
                            .padding(.vertical)
                        List(filteredCharacters) {
                            character in
                            CharacterRow(character: character)
                                .transition(.opacity)
                        }
                        .navigationTitle("Characters")
                        .animation(.easeInOut)
                        .listStyle(.inset)
                    }
                }
            }
            .onAppear {
                if charVM.characters.isEmpty && !hasError {
                    loadData()
                }
            }
            .tabItem {
                Label("Characters", systemImage: "person.fill")
            }

            Settings(isDarkMode: $isDarkMode)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    func loadData() {
        isLoading = true
        charVM.getCharacterInfo { result in
            switch result {
            case .success(let characters):
                isLoading = false
                hasError = characters.isEmpty
            case .failure(let error):
                print("Failed to fetch characters: \(error)")
                hasError = true
                isLoading = false
            }
        }
    }
}

#Preview {
    CharacterList()
}
