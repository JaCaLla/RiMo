//
//  CharacterService.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

class CharacterService: BaseService<ResponseJson<CharacterJson>> {
    open override func getPathParam() -> String {
        "character"
    }
}
