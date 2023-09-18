import Foundation

enum MovieDetailRequest: Request {
    case character(Int)

    var baseUrl: String {
        "https://swapi.dev/api/"
    }

    var path: String {
        switch self {
        case .character(let id):
            return baseUrl + "people/\(id)/"
        }
    }
}
