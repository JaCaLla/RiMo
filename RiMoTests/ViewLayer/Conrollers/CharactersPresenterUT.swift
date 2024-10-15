//
//  CharactersPresenterUT.swift
//  RiMoTests
//
//  Created by Javier Calartrava on 9/6/24.
//

@testable import RiMo
import XCTest

@preconcurrency @MainActor
final class CharactersPresenterUT: XCTestCase {
    
    var sut: CharactersPresenterProtocol!
    var interactorMock: CharactersInteractorMock!

    override func setUpWithError() throws {
        MainActor.assumeIsolated {
            interactorMock = CharactersInteractorMock()
            sut = CharactersPresenter(interactor: interactorMock)
        }
    }

    func testFetchWithData() throws {
        // Given
        // When
        interactorMock.characters = Array(repeating: Character.sample, count: 4)
        let expectation = expectation(description: "testFetchWithData")
        sut.fetch { result in
            // Then
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 4)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testFetchWithError() throws {
        // Given
        // When
        let expectation = expectation(description: "testFetchWithData")
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


final class CharactersInteractorMock: CharactersInteractorProtocol {
    
    var characters: [Character]?
    
    func fetch(completion: @escaping (Result<[RiMo.Character], any Error>) -> Void) {
        if let characters {
            completion(.success(characters))
       } else {
           completion(.failure(ErrorService.noDataResponse))
       }
    }
}
