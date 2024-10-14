//
//  CharactersPresenter.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//
import UIKit
@MainActor
protocol CharactersPresenterProtocol {
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void)
}

@MainActor
final class CharactersPresenter {
    
    // MARK: - Private attributes
    private var interactor: CharactersInteractorProtocol

    // MARK: - Constructor/Initializer
    init(interactor: CharactersInteractorProtocol = CharactersInteractor()) {
        self.interactor = interactor
    }
}

// MARK :- CharactersPresenterProtocol
extension CharactersPresenter: CharactersPresenterProtocol {
    
    func fetch(completion: @escaping (Result<[Character],Error>) -> Void) {
        interactor.fetch(completion: completion)
    }
}
