
import Foundation

// MARK: - Character
struct Character: Codable, Hashable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear, gender: String
    let homeworld: String
    let films: [String]
    let vehicles, starships: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, vehicles, starships, created, edited, url
    }
}
