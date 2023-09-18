import SwiftUI

struct MovieOverviewView: View {

    private let loadingMessage = "The force is loading"
    private let title = "Movie-overview"
    private let topPadding: CGFloat = 24
    private let horizontalPadding: CGFloat = 16
    private let dividerHeight: CGFloat = 1

    @StateObject var viewModel: MovieOverviewViewModel

    public init(viewModel: MovieOverviewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        StarWarsView {
            VStack(alignment: .leading) {
                if viewModel.isLoading {
                    loadingIndicator
                } else {
                    VStack {
                        ForEach(viewModel.sortedMovies, id: \.episodeID) { movie in
                            movieRow(movie: movie)
                        }
                        Spacer()
                    }
                    .padding(.top, topPadding)
                }
            }
            .padding(.horizontal, horizontalPadding)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.large)
        }

        .onAppear {
            Task {
                await viewModel.getMovies()
            }

        }
    }

    @ViewBuilder
    func movieRow(movie: Movie) -> some View {
        NavigationLink {
            MovieDetailView(viewModel: ViewModelDI().getMovieDetailView(movie: movie))
        } label: {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.getMovieTitle(movie: movie))
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Text(movie.releaseDate)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }

                    Image(systemName: "chevron.right")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
                Rectangle()
                    .fill(.white)
                    .frame(height: dividerHeight)
                    .edgesIgnoringSafeArea(.horizontal)
            }
        }
    }

    var loadingIndicator: some View {
        ProgressView(label: {
            Text(loadingMessage)
                .foregroundColor(.white)
                .font(.footnote)
        })
        .progressViewStyle(.circular)
        .tint(.white)
    }
}
