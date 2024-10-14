//
//  CharactersInteractorUT.swift
//  RiMoTests
//
//  Created by Javier Calartrava on 9/6/24.
//

import XCTest

@testable import RiMo
import XCTest

@preconcurrency @MainActor
final class CharactersInteractorUT: XCTestCase {
    
    var sut: CharactersInteractorProtocol!
    var dataManager: DataManagerProtocol!

    override func setUpWithError() throws {
        MainActor.assumeIsolated {
            dataManager = DataManager()
            sut = CharactersInteractor(dataManager: dataManager)
        }
    }

    func testFetchWithData() throws {
        // Given
        let dataManagerMock = DataManagerMock()
        // When
        dataManagerMock.characters = [.sample, .sample]
        sut = CharactersInteractor(dataManager: dataManagerMock)
        
        let expectation = expectation(description: "testFetchWithData")
        // When
        sut.fetch { result in
            // Then
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 2)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testFetchWithError() throws {
        let dataManagerMock = DataManagerMock()
        sut = CharactersInteractor(dataManager: dataManagerMock)
        
        let expectation = expectation(description: "testFetchWithData")
        // When
        sut.fetch { result in
            // Then
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (RiMo.ErrorService error 3.)")
            default:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}

@MainActor
final class DataManagerMock : DataManagerProtocol {

    
    var fetchCharactersCount = 0
    
    var characters: [Character]?
    
    func fetchCharacters(_ characterService: RiMo.CharacterService?) async -> Result<[RiMo.Character], any Error> {
        fetchCharactersCount += 1
        if let characters {
            return .success(characters)
        } else {
            return .failure(ErrorService.noDataResponse)
        }
    }
}

