//
//  RickAndMortyAPI.swift
//  RickAndMorty
//
//  Created by Jonathan Heinzman on 7/20/26.
//

// HERE GOES THE LOGIC TO CALL THE RNM API

/// The user wants the following data to be displayed on the app
/// name
/// Picture
/// Status
/// Race
///
///
/// THE USER NEEDS AT LEAST 2 VIEWS
///  - Main View: Renders a list of the characters
///  - Detail View: The details of that specific character

import Foundation

// An enum gives us a list of possible errors
enum APIError: Error, LocalizedError {
    
    case invalidResponse
    case decodingError
    case unknownError
    
    var errorDescription: String? {
        
        switch self {
            
        case .invalidResponse:
            return "The server returned an invalid response."
            
        case .decodingError:
            return "The character data could not be decoded."
            
        case .unknownError:
            return "Something went wrong. Please try again."
        }
    }
}

class APIService {
    
    // 1. - THE ENDPOINT -> URL
    // 2. - Build a function that calls the endpoint -> URLSession -> Calls the API using the endpoint
    // 3. - We can PARSE/DECODE the data -> JSONDecoder -> JSON into SWIFT
    
    
    // TO BE ABLE TO USE URLSessions, URLComponents we need that specific type -> URL
    // https://rickandmortyapi.com/api
    // https://rickandmortyapi.com/api/characters
    
    // When we see a "/" after a url that means that we poing towards that PATH
    // When we see a "&,$,=" that means that we are passing in PARAMETERS or PARAMS
    private let baseURL: URL = URL(
        string: "https://rickandmortyapi.com/api"
    )!
    
    // ASYNC -> for anything that takes a lil bit of time to be completed
    // THROWS -> because we handle errors if there are any
    func fetchCharacters() async throws -> [Character] {
        
        let finalURL: URL = baseURL.appendingPathComponent("character")
        
        do {
            
            // URLSession to call the api
            let (data, response) = try await URLSession.shared.data(
                from: finalURL
            )
            
            // make sure you get a response from the API
            guard let http = response as? HTTPURLResponse,
                  (200...299).contains(http.statusCode) else {
                
                throw APIError.invalidResponse
            }
            
            do {
                
                // Decode the data
                let decode = try JSONDecoder().decode(
                    CharacterResponse.self,
                    from: data
                )
                
                return decode.results
                
            } catch {
                
                throw APIError.decodingError
            }
            
        } catch let error as APIError {
            
            throw error
            
        } catch {
            
            throw APIError.unknownError
        }
    }
}
