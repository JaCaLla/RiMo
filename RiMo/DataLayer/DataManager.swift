//
//  DataManager.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

protocol DataManagerProtocol {
    func fetchCharacters(_ characterService: CharacterService?) async -> Result<[Character], Error>
}

internal final class DataManager: DataManagerProtocol {

    func fetchCharacters(_ characterService: CharacterService?) async -> Result<[Character], Error> {
        let service = characterService ?? CharacterService()
        let result = await service.fetch()
        switch result {
        case .success(let responseApiCharacterApi):
            let characters = responseApiCharacterApi.results.map { Character($0) }
            return .success(characters)
        case .failure (let error):
            return .failure(error)
        }
    }
}
