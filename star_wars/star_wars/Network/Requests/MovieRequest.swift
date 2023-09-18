import Foundation

public protocol Request {
    var baseUrl: String { get }
    var path: String { get }
}

enum MovieRequest: Request {
    case movies

    var baseUrl: String {
        "https://swapi.dev/api/"
    }

    var path: String {
        baseUrl + "films"
    }
}
