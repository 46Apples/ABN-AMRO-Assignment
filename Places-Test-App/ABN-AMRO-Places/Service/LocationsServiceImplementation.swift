import Foundation

// Encapsulates the logic to perform network requests for the app.
struct LocationsServiceImplementation {
    // [URLSession.shared] is registered in the Dependency Container as a [NetworkRequestable] conforming type. Decoupling the [LocationsServiceImplementation] from that knowledge allows injecting alternative [NetworkRequestable] implementations easily in its test suite.
    @Inject private var networkClient: NetworkRequestable
}

// MARK: [LocationsService] adoption

extension LocationsServiceImplementation: LocationsService {
    func fetchLocations() async throws -> LocationsResponse {
        let request = URLRequest.create(for: .locations)
        
        let (data, _) = try await networkClient.data(for: request)
        
        return try JSONDecoder().decode(
            LocationsResponse.self,
            from: data
        )
    }
}

// Allow access to the test instance factory method only in [DEBUG] configuration.

#if DEBUG

// MARK: Factory methods

extension LocationsServiceImplementation {
    // A factory method to create an instance of the service layer implementation for testing, using a mocked network client instance.
    static func createTestInstance(
        networkClient: NetworkRequestable
    ) -> LocationsServiceImplementation {
        var result = LocationsServiceImplementation()
        
        result.set(networkClient)
        
        return result
    }
    
    private mutating func set(_ networkClient: NetworkRequestable) {
        self.networkClient = networkClient
    }
}

#endif
