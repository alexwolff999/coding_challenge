import SwiftUI

struct MovieDetailView: View {

    @StateObject var viewModel: MovieDetailViewModel

    public init(viewModel: MovieDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        StarWarsView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(viewModel.movie.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(viewModel.movie.openingCrawl)
                        .font(.footnote)
                        .foregroundColor(.yellow)
                        .lineSpacing(5)
                        .rotation3DEffect(.degrees(20), axis: (x: 1, y: 0, z: 0))
                        .shadow(color: .gray, radius: 2, x: 0, y: 15)
                        .frame(maxWidth: .infinity)

                    Text("Cast")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 24)

                    if viewModel.isLoading {
                        ProgressView(label: {
                            Text("Characters are entering the scene. This can take some time")
                                .foregroundColor(.white)
                                .font(.footnote)
                        })
                        .progressViewStyle(.circular)
                        .tint(.white)
                    } else {
                        ForEach(viewModel.characters, id: \.self) { character in
                            VStack {
                                HStack {
                                    Text(character.name)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }.padding(.vertical, 16)
                        }

                        if viewModel.isLoadingMore {
                            ProgressView(label: {
                                Text("Characters are entering the scene. This can take some time")
                                    .foregroundColor(.white)
                                    .font(.footnote)
                            })
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .padding(.vertical, 16)
                        } else {
                            Button {
                                Task {
                                    await viewModel.loadMore()
                                }
                            } label: {
                                Text("Mehr anzeigen")
                            }.padding(.vertical, 16)
                        }


                    }

                }.padding(.horizontal, 16)
            }.onAppear {
                Task {
                    await viewModel.fetchNextCharacterPage()
                }
            }


        }
    }
}
