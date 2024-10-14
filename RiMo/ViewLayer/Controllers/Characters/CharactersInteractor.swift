//
//  CharactersInteractor.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//
@MainActor
protocol CharactersInteractorProtocol {
    func fetch(completion: @escaping (Result<[Character], Error>) -> Void)
}

@MainActor
final class CharactersInteractor {
    private var dataManager: DataManagerProtocol
    
    // MARK: - Constructor/Initializer
    init(dataManager: DataManagerProtocol = currentApp.dataManager) {
        self.dataManager = dataManager
    }
}

// MARK :- CharactersInteractorProtocol
extension CharactersInteractor: CharactersInteractorProtocol {
    
    func fetch(completion: @escaping (Result<[Character], Error>) -> Void) {
        Task {
            let result = await dataManager.fetchCharacters(nil)
            completion(result)
        }
    }
}
