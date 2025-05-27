import Testing
@testable import ABN_AMRO_Places

final class LocationsCoordinatorTests {
    private var serviceUnderTest: LocationsCoordinator?
    private var mockAppLauncher: MockExternalAppLauncher?
    
    deinit {
        resetServiceUnderTest()
        
        resetMocks()
    }
    
    @Test("navigate(:) does not attempt to open Wikipedia when the external app launcher cannot open the given URL")
    @MainActor func testNavigateWhenAppLauncherCannotOpenURL() {
        try? createServiceUnderTest(
            externalAppLauncher: .init(stubbedResult: false)
        )
        
        serviceUnderTest?.navigate(to: .mockLocation)
        
        #expect(mockAppLauncher?.didInvokeCanOpen(with: .mockLocationUrl) == true)
        
        #expect(mockAppLauncher?.didInvokeOpen == false)
    }
    
    @Test("navigate(:) attempts to open Wikipedia when the external app launcher can open the given URL")
    @MainActor func testNavigateWhenAppLauncherCanOpenURL() {
        try? createServiceUnderTest(
            externalAppLauncher: .init(stubbedResult: true)
        )
        
        serviceUnderTest?.navigate(to: .mockLocation)
        
        #expect(mockAppLauncher?.didInvokeCanOpen(with: .mockLocationUrl) == true)
        
        #expect(mockAppLauncher?.didInvokeOpen(with: .mockLocationUrl) == true)
    }
}

// MARK: Private

extension LocationsCoordinatorTests {
    private func createServiceUnderTest(
        externalAppLauncher: MockExternalAppLauncher
    ) throws {
        mockAppLauncher = externalAppLauncher
        
        serviceUnderTest = LocationsCoordinator.createTestInstance(
            appLauncher: try #require(mockAppLauncher)
        )
    }
    
    private func resetServiceUnderTest() {
        serviceUnderTest = nil
    }
    
    private func resetMocks() {
        mockAppLauncher = nil
    }
}
