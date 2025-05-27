import Testing
import Foundation
@testable import ABN_AMRO_Places

final class DependencyContainerTests {
    
    @Test("Test that the expected dependencies are registered with DI container")
    func testExpectedDependenciesAreRegisteredWithDIContainer() {
        #expect(DependencyContainer.resolvedDependency() as NetworkRequestable is URLSession)
        #expect(DependencyContainer.resolvedDependency() as ExternalAppLaunching is UIKitApplication)
        #expect(DependencyContainer.resolvedDependency() as LocationsCoordinating is LocationsCoordinator)
        #expect(DependencyContainer.resolvedDependency() as LocationsService is LocationsServiceImplementation)
    }
}
