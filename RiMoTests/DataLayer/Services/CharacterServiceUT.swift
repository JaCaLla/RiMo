//
//  CharacterServiceUT.swift
//  RiMoTests
//
//  Created by Javier Calartrava on 9/6/24.
//

@testable import RiMo
import XCTest

final class CharacterServiceUT: XCTestCase {
    
    var sut: CharacterService!

    override func setUpWithError() throws {
        sut = CharacterService()
    }

    func testFetchCharacters() async throws {
        switch await sut.fetch() {
        case .success(let responseService):
            XCTAssertEqual(responseService.info.count, 826)
            XCTAssertEqual(responseService.results[0].name, "Rick Sanchez")
            XCTAssertEqual(responseService.results[0].image, "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
            XCTAssertEqual(responseService.results[0].status, "Alive")
            XCTAssertEqual(responseService.results[0].species, "Human")
            XCTAssertEqual(responseService.results[0].type, "")
            XCTAssertEqual(responseService.results[0].location.name, "Citadel of Ricks")
            XCTAssertEqual(responseService.results[0].episode.count, 51)
        default:
            XCTFail("Unexpected response")
        }
    }

    func testFetchNoData() async throws {
        sut.forcedErrorApi = .noDataResponse
        switch await sut.fetch() {
        case .success(_):
            XCTFail("Unexpected response")
        case .failure(let errorApi):
            XCTAssertEqual(errorApi.localizedDescription, "The operation couldn’t be completed. (RiMo.ErrorService error 3.)")
        }
    }

    func testFetchMockData() async throws {
        let responseApi: ResponseJson<CharacterJson> = ResponseJson(info: InfoJson(count: 2), results: [CharacterJson.sample])
        sut.forcedResposeApi = responseApi
        switch await sut.fetch() {
        case .success(let responseAPI):
            XCTAssertEqual(responseAPI.info.count, 2)
            XCTAssertEqual(responseAPI.results[0].name, "a")
            XCTAssertEqual(responseAPI.results[0].image, "b")
            XCTAssertEqual(responseAPI.results[0].status, "c")
            XCTAssertEqual(responseAPI.results[0].species, "d")
            XCTAssertEqual(responseAPI.results[0].type, "e")
            XCTAssertEqual(responseAPI.results[0].location.name, "l")
            XCTAssertEqual(responseAPI.results[0].episode.count, 3)
        case .failure(_):
            XCTFail("Unexpected response")
        }
        
    }
}

extension CharacterJson {
    static let sample = CharacterJson(name: "a", image: "b", status: "c", species: "d", type: "e", episode: ["x", "y", "z"], location: .sample)
}

extension LocationJson {
    static let sample = LocationJson(name: "l")
}
