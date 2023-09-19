import Foundation

struct ViewModelDI {
    public init() {}

    public func getMovieOverviewViewModel() -> MovieOverviewViewModel {
        MovieOverviewViewModel(service: ServiceDI().getMovieService())
    }

    public func getMovieDetailView(movie: Movie) -> MovieDetailViewModel {
        MovieDetailViewModel(movie: movie, detailService: ServiceDI().getMovieDetailService())
    }
}


struct ServiceDI {
    public init() {}

    public func getMovieService() -> MovieServicing {
        MovieService()
    }

    public func getMovieDetailService() -> MovieDetailServicing {
        MovieDetailService()
    }
}
