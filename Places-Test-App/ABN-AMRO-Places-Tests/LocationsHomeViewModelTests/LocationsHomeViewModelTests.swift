import Testing
@testable import ABN_AMRO_Places

final class LocationsHomeViewModelTests {
    private var serviceUnderTest: LocationsHomeViewModel?
    private var mockService: MockLocationsService<Any>?
    
    deinit {
        resetServiceUnderTest()
        
        resetMocks()
    }
    
    @Test("fetchLocations() that sets error view state when service request fails")
    func testFetchLocationsThatFails() async {
        try? createServiceUnderTest(
            service: Mock.stubbed(
                result: .failure(MockError.error)
            )
        )
        
        #expect(serviceUnderTest?.viewState == .loading)
        
        await serviceUnderTest?.fetchLocations()
        
        #expect(serviceUnderTest?.viewState == .error)
        
        #expect(mockService?.didInvokeFetchLocations == true)
    }
    
    @Test("fetchLocations() that sets loaded view state when service request succeeds")
    func testFetchLocationsThatSucceeds() async {
        try? createServiceUnderTest(
            service: Mock.stubbed(
                result: .success(LocationsResponse.mockDecodedLocationsResponse)
            )
        )
        
        #expect(serviceUnderTest?.viewState == .loading)
        
        await serviceUnderTest?.fetchLocations()
        
        #expect(serviceUnderTest?.viewState == .loaded(locations: .mockLocations))
        
        #expect(mockService?.didInvokeFetchLocations == true)
    }
    
    @Test("addLocation() does not update view state when new location data is missing")
    @MainActor func testAddLocationThatFails() {
        try? createServiceUnderTest(
            initialLocations: .mockLocations,
            initialViewState: .loaded(locations: .mockLocations)
        )
        
        #expect(serviceUnderTest?.viewState == .loaded(locations: .mockLocations))
        
        serviceUnderTest?.addLocation(using: .mockEmptyNewLocation)
        
        #expect(serviceUnderTest?.viewState == .loaded(locations: .mockLocations))
    }
    
    @Test("addLocation() updates the view state when new location data is valid")
    @MainActor func testAddLocationThatSucceeds() {
        try? createServiceUnderTest(
            initialLocations: .mockLocations,
            initialViewState: .loaded(locations: .mockLocations)
        )
        
        #expect(serviceUnderTest?.viewState == .loaded(locations: .mockLocations))
        
        serviceUnderTest?.addLocation(using: .mockNewLocation)
        
        #expect(serviceUnderTest?.viewState == .loaded(locations: .mockLocationsWithAddedItem))
    }
}

// MARK: Private

extension LocationsHomeViewModelTests {
    private func createServiceUnderTest(
        service: MockLocationsService<Any> = Mock.stubbed(result: .success(())),
        initialLocations: [LocationsModel] = [],
        initialViewState: LocationsHomeViewState = .loading
    ) throws {
        mockService = service
        
        serviceUnderTest = LocationsHomeViewModel.createTestInstance(
            service: try #require(mockService),
            locations: initialLocations,
            viewState: initialViewState
        )
    }
    
    private func resetServiceUnderTest() {
        serviceUnderTest = nil
    }
    
    private func resetMocks() {
        mockService = nil
    }
}
