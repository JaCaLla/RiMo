//
//  CharactersPresenter.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//
import UIKit

protocol CharactersPresenterProtocol {
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void)
}

class CharactersPresenter {
    
}

// MARK :- CharactersPresenterProtocol
extension CharactersPresenter: CharactersPresenterProtocol {
    
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void) {
        Task {
            let service = CharacterService()
            let result = await service.fetch()
            switch result {
            case .success(let responseApiCharacterApi):
                let characters = responseApiCharacterApi.results.map { Character($0) }
                completion(.success(characters))
            case .failure (let error):
                completion(.failure(error))
            }
        }
    }
}
