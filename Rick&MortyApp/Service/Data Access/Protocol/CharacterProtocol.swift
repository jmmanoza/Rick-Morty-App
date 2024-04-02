//
//  CharacterProtocol.swift
//  Rick&MortyApp
//
//  Created by jmmanoza on 4/2/24.
//

import Foundation

protocol CharacterProtocol {
    func getAllCharacters() async throws -> [Character]
    func getSingleCharacter(with id: Int) async throws -> Character
}
