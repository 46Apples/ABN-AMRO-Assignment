import SwiftUICore
import OSLog

@Observable
final class LocationsHomeViewModel {
    // [@ObservationIgnored] added to the [LocationsService] property declaration, as the [@Inject] property wrapper cannot be used in a class marked with [@Observable]. This is because properties are converted into computed properties under the hood when using [@Observable].
    @ObservationIgnored
    @Inject private var service: LocationsService
    private let logger = Logger(category: "\(LocationsHomeViewModel.self)")
    private(set) var viewState: LocationsHomeViewState = .loading
    private var locations = [LocationsModel]()
}

// MARK: [LocationsHomeViewModelling] adoption

extension LocationsHomeViewModel: LocationsHomeViewModelling {
    // Attempts to fetch the list of locations from the network, setting the view state accordingly during the process.
    func fetchLocations() async {
        // Set the initial view state to [loading]
        setLoadingViewState()
        
        do {
            // Attempt to fetch the list of locations from the network, parse the response and set the view state to [loaded] if the request is successful.
            locations = try await service.fetchLocations().parse()
            
            setLoadedViewState()
        } catch {
            // Set the view state to [error] if the request to fetch the list of locations fails.
            setErrorViewState()
        }
    }
    
    // Adds a new location to the [locations] array.
    func addLocation(using model: NewLocationModel) {
        // Ensure the view state is set to loaded once the method completes its work.
        defer { setLoadedViewState() }
        
        guard let lattitude = model.lattitude,
              let longitude = model.longitude else {
            logger.error("Failed to add the new location - missing values for lattitude or longitude")
            
            return
        }
        
        addLocation(with: model.name, lattitude: lattitude, longitude: longitude)
    }
}

// MARK: View state helper methods

extension LocationsHomeViewModel {
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

// MARK: Private

extension LocationsHomeViewModel {
    private func addLocation(with name: String, lattitude: Double, longitude: Double) {
        locations.append(
            .init(name: name,lattitude: lattitude,longitude: longitude)
        )
    }
}

// Allow access to the test instance factory method only in [DEBUG] configuration.

#if DEBUG

// MARK: Factory methods

extension LocationsHomeViewModel {
    // A factory method to create an instance of the view model for testing, using a mocked service instance, and any initial state required during test setup.
    static func createTestInstance(
        service: LocationsService,
        locations: [LocationsModel] = [],
        viewState: LocationsHomeViewState = .loading
    ) -> LocationsHomeViewModel {
        let result = LocationsHomeViewModel()
        
        result.service = service
        result.viewState = viewState
        result.locations = locations
        
        return result
    }
}

#endif
