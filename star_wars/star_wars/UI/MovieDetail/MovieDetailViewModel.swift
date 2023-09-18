
import Foundation

class MovieDetailViewModel: ObservableObject {

    let movie: Movie
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var characters: [Character] = []
    let detailService: MovieDetailServicing
    var characterIds: [Int] = []
    var page = 1
    var charactersPerPage = 3

    init(movie: Movie, detailService: MovieDetailServicing) {
        self.movie = movie
        self.detailService = detailService
        characterIds = getIdsForCharacter()

    }

    func fetchNextCharacterPage() async {
        isLoading = true
        characters += await detailService.fetchCharacterDetails(pages: characterIds[0...page * charactersPerPage].map { $0} )
        isLoading = false
    }

    func loadMore() async {
        let start = page * charactersPerPage + 1
        let end = (page + 1) * charactersPerPage
        isLoadingMore = true

        characters += await detailService.fetchCharacterDetails(pages: characterIds[start...end].map { $0} )
        page += 1
        isLoadingMore = false
    }

    private func getIdsForCharacter() -> [Int] {
        var ids: [Int] = []
        for characterUrl in movie.characters {
            do {
                let regex = try NSRegularExpression(pattern: "/(\\d+)/$", options: [])
                let range = NSRange(characterUrl.startIndex..<characterUrl.endIndex, in: characterUrl)

                if let match = regex.firstMatch(in: characterUrl, options: [], range: range) {
                    let nsString = characterUrl as NSString
                    let lastNumberRange = match.range(at: 1)
                    let lastNumber = nsString.substring(with: lastNumberRange)
                    if let intId = Int(lastNumber) {
                        ids.append(intId)
                    }
                }
            } catch {
                return []
            }
        }

        return ids
    }
}
