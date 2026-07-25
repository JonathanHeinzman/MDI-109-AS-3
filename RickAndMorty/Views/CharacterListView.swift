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
        NavigationStack{
            Group{
                if VM.isLoading {
                    ProgressView("Loading Characters...")
                } else if let error = VM.errorMessage{
                    VStack{
                        Text(error)
                        Button("Retry"){
                            Task{
                                await VM.loadCharacter()
                            }
                        }
                    }
                } else {
                    List(VM.character){ character in
                        NavigationLink(value: character){
                            
                            // ASYNC IMAGES
                            AsyncImage(url: URL(string:character.image)){ phase in
                                // HANDLE POSSIBLE STATES
                                switch phase{
                                case .empty: ProgressView()
                                case .failure: Image(systemName: "person.fill.questionmark")
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                @unknown default:
                                    EmptyView()
                                }
                                
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(.circle)
                            VStack{
                                Text(character.name)
                                HStack{
                                    Text(character.status)
                                    Text(character.species)
                                }.font(.subheadline)
                                
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Characters")
            .navigationDestination(for: Character.self){
                character in
                CharacterDetailView()
            }
        }.task{
            await VM.loadCharacter()
        }
        
        
    }
}

#Preview {
    CharacterListView()
}
