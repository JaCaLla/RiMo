//
//  MainFlowCoordinator.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import Foundation
import UIKit


class MainFlowCoordinator {
    
    // MARK: - Singleton handler
    static let shared = MainFlowCoordinator()
    
    // MARK: - Private attributes
    private let navigationController =  UINavigationController()
    private let charactersCoordinator = CharactersCoordinator()
    
    
    private init() { /*This prevents others from using the default '()' initializer for this class. */ }
    
    // MARK: - Pulic methods
    func start() {
        presentHome()
    }
    
    // MARK: - Private/Internal
    private func presentHome() {
        
        charactersCoordinator.start(navitagionController: navigationController)
        
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .last { $0.isKeyWindow }
        window?.rootViewController  = navigationController
    }
}
