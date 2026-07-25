//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Jonathan Heinzman on 7/20/26.
//

import SwiftUI

struct CharacterDetailView: View {
    
    let character: Character
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                // ASYNC IMAGE
                AsyncImage(
                    url: URL(string: character.image)
                ) { phase in
                    
                    // HANDLE POSSIBLE STATES
                    switch phase {
                        
                    case .empty:
                        
                        ProgressView()
                        
                    case .failure:
                        
                        Image(
                            systemName: "person.fill.questionmark"
                        )
                        .font(.largeTitle)
                        
                    case .success(let image):
                        
                        image
                            .resizable()
                            .scaledToFit()
                        
                    @unknown default:
                        
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 15
                    )
                )
                
                Text(character.name)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 15) {
                    
                    HStack {
                        
                        Text("Status")
                            .bold()
                        
                        Spacer()
                        
                        Text(character.status)
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        Text("Species")
                            .bold()
                        
                        Spacer()
                        
                        Text(character.species)
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        Text("Gender")
                            .bold()
                        
                        Spacer()
                        
                        Text(character.gender)
                    }
                    
                    Divider()
                    
                    HStack {
                        
                        Text("Origin")
                            .bold()
                        
                        Spacer()
                        
                        Text(character.origin.name)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding()
                .background(
                    Color.gray.opacity(0.1)
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 12
                    )
                )
            }
            .padding()
        }
        .navigationTitle("Character Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    
    NavigationStack {
        
        CharacterDetailView(
            character: Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                gender: "Male",
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                origin: Origin(
                    name: "Earth"
                )
            )
        )
    }
}
