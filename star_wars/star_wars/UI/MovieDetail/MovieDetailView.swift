import SwiftUI

struct MovieDetailView: View {

    private var lineSpacing = 5.0
    private let rotationDegree: Double = 20
    private let rotationXAxis: Double = 1
    private let shadowRadius: Double = 2
    private let shadowYValue: Double = 15
    private let castVerticalPadding: CGFloat = 24
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 16

    private let castTitle = "Cast"
    private let loadingMessage = "Characters are entering the scene. This can take some time"
    private let showMore = "Show more"

    @StateObject var viewModel: MovieDetailViewModel

    public init(viewModel: MovieDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        StarWarsView {
            ScrollView {
                VStack(alignment: .leading) {
                    titleSection()
                    castSection()
                }.padding(.horizontal, horizontalPadding)
            }.onAppear {
                Task {
                    await viewModel.fetchNextCharacterPage()
                }
            }


        }
    }

    @ViewBuilder
    func titleSection() -> some View {
        Text(viewModel.movie.title)
            .font(.headline)
            .foregroundColor(.white)
        Text(viewModel.movie.openingCrawl)
            .font(.footnote)
            .foregroundColor(.yellow)
            .lineSpacing(lineSpacing)
            .rotation3DEffect(.degrees(rotationDegree), axis: (x: rotationXAxis, y: 0, z: 0))
            .shadow(color: .gray, radius: shadowRadius, x: 0, y: shadowYValue)
            .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    func castSection() -> some View {
        Text(castTitle)
            .font(.headline)
            .foregroundColor(.white)
            .padding(.vertical, castVerticalPadding)

        if viewModel.isLoading {
            loadingIndicator
        } else {
            ForEach(viewModel.characters, id: \.self) { character in
                VStack {
                    HStack {
                        Text(character.name)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }.padding(.vertical, verticalPadding)
            }

            if viewModel.isLoadingMore {
                loadingIndicator
                    .padding(.vertical, verticalPadding)
            } else {
                Button {
                    Task {
                        await viewModel.loadMore()
                    }
                } label: {
                    Text(showMore)
                }.padding(.vertical, verticalPadding)
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
