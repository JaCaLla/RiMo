//
//  CharactersCoordinator.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import UIKit

final class CharactersCoordinator {
    
    // MARK: - Private attributes
    internal var navigationController = UINavigationController()
    
    // MARK: - Public helpers
    func start(navitagionController: UINavigationController) {
        self.navigationController = navitagionController
        presentCharacterList()
    }
    
    // MARK: - Private methods
    private func presentCharacterList() {
        let interactor = CharactersInteractor()
        let presenter = CharactersPresenter(interactor: interactor)
        let charactersViewController = CharactersViewController.instantiate(presenter: presenter)
        navigationController.pushViewController(charactersViewController, animated: true)
    }
}
