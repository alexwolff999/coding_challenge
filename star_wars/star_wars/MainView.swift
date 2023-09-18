import SwiftUI

@main
struct MainView: App {
    var body: some Scene {
        WindowGroup {
            MovieOverviewView(viewModel: ViewModelDI().getMovieOverviewViewModel())
        }
    }
}
