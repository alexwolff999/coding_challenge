import Foundation

protocol MovieDetailServicing {
    func fetchCharacterDetails(pages: [Int]) async -> [Character]
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
}
