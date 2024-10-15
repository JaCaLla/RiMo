//
//  DataManagerUT.swift
//  RiMoTests
//
//  Created by Javier Calartrava on 9/6/24.
//

import XCTest

@testable import RiMo
import XCTest
final class DataManagerUT: XCTestCase {

    var sut: DataManager!

    override func setUpWithError() throws {
        sut = DataManager()
    }

    func testFetchCharactersRealData() async throws {

        let result = await sut.fetchCharacters(nil)
        switch result {
        case .success(let characters):
            XCTAssertEqual(characters[0].name, "Rick Sanchez")
            XCTAssertEqual(characters[0].imageUrl, "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
            XCTAssertEqual(characters[0].status, "Alive")
            XCTAssertEqual(characters[0].species, "Human")
            XCTAssertEqual(characters[0].type, "")
            XCTAssertEqual(characters[0].location, "Citadel of Ricks")
            XCTAssertEqual(characters[0].numberOfEpisodes, 51)
        default:
            XCTFail()
        }
    }

    func testFetchCharactersWithError() async throws {
        let characterService = await CharacterService()

        let baseService = await characterService.baseService
        await baseService.setforcedErrorApi(.noDataResponse)

        let result = await sut.fetchCharacters(characterService)
        switch result {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (RiMo.ErrorService error 3.)")
        default:
            XCTFail()
        }
    }
    
    func testFetchCharactersMockData() async throws {
        let characterService = await CharacterService()
        let responseJson: ResponseJson<CharacterJson> = ResponseJson(info: InfoJson(count: 2), results: [CharacterJson.sample])
        let baseService = await characterService.baseService
        await baseService.setforcedResposeApi(responseJson)

        let result = await sut.fetchCharacters(characterService)
        switch result {
        case .success(let characters):
            XCTAssertEqual(characters.count, 1)
            XCTAssertEqual(characters[0].name, "a")
            XCTAssertEqual(characters[0].imageUrl, "b")
            XCTAssertEqual(characters[0].status, "c")
            XCTAssertEqual(characters[0].species, "d")
            XCTAssertEqual(characters[0].type, "e")
            XCTAssertEqual(characters[0].location, "l")
            XCTAssertEqual(characters[0].numberOfEpisodes, 3)
        default:
            XCTFail()
        }
    }
}
