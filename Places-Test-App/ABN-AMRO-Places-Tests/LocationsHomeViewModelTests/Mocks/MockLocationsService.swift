@testable import ABN_AMRO_Places

// Subclasses [MockStub] in order to get access to generic stubbed responses from the mock.
// [T] is used to inform [MockStub] what data type it should create a stubbed response for.
class MockLocationsService<T: Any>: MockStub<T> {
    private(set) var didInvokeFetchLocations = false
    
    func resetForTesting() {
        super.reset()
        
        didInvokeFetchLocations = false
    }
}

// MARK: [LocationsService] adoption

extension MockLocationsService: LocationsService {
    func fetchLocations() async throws -> LocationsResponse {
        didInvokeFetchLocations = true
        
        guard let result = stubbedResult else { throw MockError.error }
        
        switch result {
        case .success(let value):
            guard let value = value as? LocationsResponse else { throw MockError.error }
            return value
        case .failure(let error):
            throw error
        }
    }
}
