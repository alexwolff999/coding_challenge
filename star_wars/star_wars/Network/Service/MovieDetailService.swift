//
//  MovieDetailService.swift
//  star_wars
//
//  Created by Alexander Wolff on 18.09.23.
//

import Foundation

protocol MovieDetailServicing {
    func fetchCharacterDetails(pages: [Int]) async -> [Character]
    func fetchPlanetDetails() async -> [Planet]
}

class MovieDetailService: MovieDetailServicing{
    func fetchCharacterDetails(pages: [Int]) async -> [Character] {
        var characters: [Character] = []
        for page in pages {
            let response = await HttpClient.sendRequest(request: MovieDetailRequest.character(page), responseModel: Character.self)

            switch response {
            case .success(let character):
                characters.append(character)
            case .failure(_):
                return []
            }
        }

        return characters
    }

    func fetchPlanetDetails() async -> [Planet] {
        return []
    }


}


//let response = await HttpClient.sendRequest(request: MovieDetailRequest.character(page), responseModel: CharacterResponse.self)
//
//switch response {
//case .success(let success):
//    if success.next != nil {
//        let nextPageResult = await fetchCharacterDetails(page: page + 1)
//        return success.results + nextPageResult
//    } else {
//        return success.results
//    }
//case .failure(_):
//    return []
//    }
