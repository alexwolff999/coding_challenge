import Foundation

protocol MovieServicing {
    func fetchMovies() async -> [Movie]
}

class MovieService: MovieServicing {
    func fetchMovies() async -> [Movie]{
        let response = await HttpClient.sendRequest(request: MovieRequest.movies, responseModel: Movies.self)

        switch response {
        case .success(let movies):
            return movies.results
        case .failure(_):
            return []
        }
    }
}
