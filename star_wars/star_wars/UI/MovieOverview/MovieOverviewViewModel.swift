import Foundation

class MovieOverviewViewModel: ObservableObject {

    @Published var isLoading = false
    @Published var movies: [Movie] = []

    let service: MovieServicing

    init(service: MovieServicing) {
        self.service = service
    }

    var sortedMovies: [Movie] {
        movies.sorted { a, b in
            a.episodeID < b.episodeID
        }
    }

    func getMovies() async {
        isLoading = true
        movies = await service.fetchMovies()
        isLoading = false
    }

    func getMovieTitle(movie: Movie) -> String {
        "Movie \(movie.episodeID): \(movie.title)"
    }
}
