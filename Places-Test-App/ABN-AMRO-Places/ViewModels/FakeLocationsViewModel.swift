import SwiftUICore
import OSLog

// A fake view model that can be used to test the various UI view states without having to make actual network requests to fetch the data.
@Observable
class FakeLocationsViewModel: LocationsHomeViewModelling {
    private(set) var viewState: LocationsHomeViewState = .loading
    private let logger = Logger(category: "\(FakeLocationsViewModel.self)")
    private var locations: [LocationsModel] = .exampleLocations
    
    func fetchLocations() async {
        setLoadingViewState()
        
        try? await Task.sleep(for: .seconds(1))
        
        setLoadedViewState()
    }
    
    func addLocation(using model: NewLocationModel) {
        defer { setLoadedViewState() }
        
        guard let lattitude = model.lattitude, let longitude = model.longitude else {
            logger.error("Failed to add the new location - missing values for lattitude or longitude")
            
            return
        }
        
        locations.append(
            .init(
                name: model.name,
                lattitude: lattitude,
                longitude: longitude)
        )
    }
}

// MARK: View States

extension FakeLocationsViewModel {
    private func setLoadingViewState() {
        viewState = .loading
    }
    
    private func setErrorViewState() {
        viewState = .error
    }
    
    private func setLoadedViewState() {
        viewState = .loaded(locations: locations)
    }
}
