//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Jonathan Heinzman on 7/20/26.
//

import Foundation

struct CharacterResponse: Codable {
    
    // This is an array of characters
    
    let results: [Character]
}

struct Character: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let origin: Origin
}

struct Origin: Codable, Hashable {
    
    let name: String
}
