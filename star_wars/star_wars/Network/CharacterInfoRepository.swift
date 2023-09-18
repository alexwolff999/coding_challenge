import Foundation

protocol CharacterInfoRepositoryProtocol {
    func getCharacters() async -> [Character]
}

class CharacterInfoRepository: CharacterInfoRepositoryProtocol {

    let detailService: MovieDetailServicing

    init(detailService: MovieDetailServicing) {
        self.detailService = detailService
    }

    public func getCharacters() async -> [Character] {
        if let charactes = CharacterInfoStorage.shared.characters {
            return charactes
        } else {
           let characters = await detailService.fetchCharacterDetails(page: 0)
            CharacterInfoStorage.shared.characters = characters
            return characters
        }
    }
}

private struct CharacterInfoStorage {
    public static var shared = CharacterInfoStorage()
    private init() { }
    public var characters: [Character]?
}
