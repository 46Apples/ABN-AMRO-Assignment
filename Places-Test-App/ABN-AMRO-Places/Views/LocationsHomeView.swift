import SwiftUI

// Represents the main UI that is rendered when the app first launches.
struct LocationsHomeView: View {
    @Environment(\.locationsViewModel) private var viewModel: LocationsHomeViewModelling
    private var viewState: LocationsHomeViewState { viewModel.viewState }
    
    var body: some View {
        VStack {
            // Render the UI based on the current view state in the view model.
            switch viewState {
            case .loading:
                ActivityIndicatorView()
            case .error:
                ErrorWithRetryView {
                    fetchLocations()
                }
            case .loaded(let locations):
                LocationsListView{ newLocation in
                    add(newLocation)
                }
                .environment(\.locationListModel, locations)
            }
        }.task {
            fetchLocations()
        }
    }
}

// MARK: Private

extension LocationsHomeView {
    private func fetchLocations() {
        Task { await viewModel.fetchLocations() }
    }
    
    private func add(_ newLocation: NewLocationModel) {
        viewModel.addLocation(using: newLocation)
    }
}

#Preview {
    LocationsHomeView()
}
