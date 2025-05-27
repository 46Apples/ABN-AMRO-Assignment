import Testing
import Foundation
@testable import ABN_AMRO_Places

final class LocationsServiceTests {
    private var serviceUnderTest: LocationsServiceImplementation?
    private var mockNetworkClient: MockNetworkClient<Any>?
    
    deinit {
        resetServiceUnderTest()
        
        resetMocks()
    }
    
    @Test("fetchLocations() should invoke network client with expected parameters and return expected response")
    func testFetchLocations() async {
        try? createServiceUnderTest(
            networkClient: Mock.stubbed(
                result: .success(Data.mockRawLocationsResponse)
            )
        )
        
        let actual = try? await serviceUnderTest?.fetchLocations()
        
        #expect(actual == .mockDecodedLocationsResponse)
        
        #expect(mockNetworkClient?.wasInvoked(
            with: .expectedLocationsUrl,
            httpMethod: .expectedHttpMethod
        ) == true)
    }
}

// MARK: Private

extension LocationsServiceTests {
    private func createServiceUnderTest(networkClient: MockNetworkClient<Any>) throws {
        mockNetworkClient = networkClient
        
        serviceUnderTest = LocationsServiceImplementation.createTestInstance(
            networkClient: try #require( mockNetworkClient)
        )
    }
    
    private func resetServiceUnderTest() {
        serviceUnderTest = nil
    }
    
    private func resetMocks() {
        mockNetworkClient = nil
    }
}

// MARK: Test constants

fileprivate extension URL {
    static var expectedLocationsUrl: URL {
        URL(string: .expectedLocationsUrlString)!
    }
}

fileprivate extension String {
    static var expectedLocationsUrlString: String {
        "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"
    }
    
    static var expectedHttpMethod: String {
        "GET"
    }
}
