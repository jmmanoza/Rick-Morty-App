//
//  CharacterDataService.swift
//  Rick&MortyApp
//
//  Created by jmmanoza on 4/2/24.
//

import Foundation

class CharacterDataService: CharacterProtocol {
    func getSingleCharacter(with id: Int) async throws -> Character {
        let url = "https://rickandmortyapi.com/api/character/\(id)"
        
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(Character.self, from: data)
        } catch {
            throw APIError.invalidData
        }
    }
    
    func getAllCharacters() async throws -> [Character] {
        let url = "https://rickandmortyapi.com/api/character"
        
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let character = try JSONDecoder().decode(CharacterRoot.self, from: data)
            return character.results
        } catch {
            throw APIError.invalidData
        }
    }
}

class CharacterMockService: CharacterProtocol {
    func getSingleCharacter(with id: Int) async throws -> Character {
        guard let url = Bundle.main.url(forResource: "SingleCharacter", withExtension: "json") else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            return try JSONDecoder().decode(Character.self, from: data)
        } catch {
            throw APIError.invalidData
        }
    }
    
    func getAllCharacters() async throws -> [Character] {
        guard let url = Bundle.main.url(forResource: "Character", withExtension: "json") else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let character = try JSONDecoder().decode(CharacterRoot.self, from: data)
            return character.results
        } catch {
            throw APIError.invalidData
        }
    }
}
