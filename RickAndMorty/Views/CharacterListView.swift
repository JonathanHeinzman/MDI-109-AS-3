//
//  Untitled.swift
//  RickAndMorty
//
//  Created by Jonathan Heinzman on 7/20/26.
//

import SwiftUI

struct CharacterListView: View {
    
    @StateObject private var VM: RNMViewModel = RNMViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            Group {
                
                if VM.isLoading {
                    
                    ProgressView("Loading Characters...")
                    
                } else if let error = VM.errorMessage {
                    
                    VStack(spacing: 15) {
                        
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                        
                        Text(error)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            
                            Task {
                                await VM.loadCharacter()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    
                } else {
                    
                    List(VM.character) { character in
                        
                        NavigationLink(value: character) {
                            
                            HStack(spacing: 12) {
                                
                                // ASYNC IMAGES
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
                                        
                                    case .success(let image):
                                        
                                        image
                                            .resizable()
                                            .scaledToFill()
                                        
                                    @unknown default:
                                        
                                        EmptyView()
                                    }
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(.circle)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    Text(character.name)
                                        .font(.headline)
                                    
                                    HStack {
                                        
                                        Text(character.status)
                                        
                                        Text("•")
                                        
                                        Text(character.species)
                                    }
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Characters")
            .navigationDestination(for: Character.self) { character in
                
                CharacterDetailView(character: character)
            }
        }
        .task {
            
            await VM.loadCharacter()
        }
    }
}

#Preview {
    CharacterListView()
}
