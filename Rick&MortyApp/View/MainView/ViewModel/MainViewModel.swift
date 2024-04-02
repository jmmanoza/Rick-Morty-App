//
//  MainViewModel.swift
//  Rick&MortyApp
//
//  Created by jmmanoza on 4/2/24.
//

import Foundation

class MainViewModel: ObservableObject {
    
    let service: CharacterProtocol
    
    @Published var characters: [Character] = []
    @Published var character: Character?
    @Published var isLoading: Bool = false
    @Published var errorMsg: String = ""
    
    init(service: CharacterProtocol) {
        self.service = service
    }
    
    @MainActor
    func getAllCharacters() async {
        isLoading = true
        do {
            let characters = try await service.getAllCharacters()
            self.characters = characters
            self.isLoading = false
            print("get all characters. \(self.characters)")
        } catch(let error) {
            self.isLoading = false
            self.errorMsg = error.localizedDescription
            print("error found: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func getSingleCharacter(with id: Int) async {
        isLoading = true
        do {
            let character = try await service.getSingleCharacter(with: id)
            self.character = character
        } catch(let error) {
            self.errorMsg = error.localizedDescription
        }
    }
}
