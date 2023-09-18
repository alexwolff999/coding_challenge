import SwiftUI

struct MovieOverviewView: View {
    @StateObject var viewModel: MovieOverviewViewModel

    public init(viewModel: MovieOverviewViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        StarWarsView {
            VStack(alignment: .leading) {
                if viewModel.isLoading {
                    ProgressView(label: {
                       Text("The force is loading")
                            .foregroundColor(.white)
                            .font(.footnote)
                    })
                        .progressViewStyle(.circular)
                        .tint(.white)
                } else {
                    VStack {
                        ForEach(viewModel.sortedMovies, id: \.episodeID) { movie in
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
                                        .frame(height: 1)
                                        .edgesIgnoringSafeArea(.horizontal)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 24)
                }
            }
            .padding(.horizontal, 16)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.large)
        }

        .onAppear {
            Task {
                await viewModel.getMovies()
            }

        }
    }
}
