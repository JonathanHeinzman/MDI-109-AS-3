//
//  RNMViewModel.swift
//  RickAndMorty
//
//  Created by Jonathan Heinzman on 7/20/26.
//

import Foundation // Primitive Types and Functions
import Combine // MVVM Pattern

@MainActor
class RNMViewModel: ObservableObject {
    // 1. - Get the character
    // 2. - Set them to Variables for the UI
    // 3. - CATCH ANY ERRORS
    
    @Published var character: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let API = APIService()
    
    func loadCharacter() async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            
            character = try await API.fetchCharacters()
            
        } catch {
            
            errorMessage = "Error: \(error.localizedDescription)"
            
        }
        
        isLoading = false
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
