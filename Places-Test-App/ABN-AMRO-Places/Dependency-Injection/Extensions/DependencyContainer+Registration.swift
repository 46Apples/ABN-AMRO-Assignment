import Foundation

// A helper method to encapsulate the registration of all required dependencies with the Dependency Container.
extension DependencyContainer {
    static func registerDependencies() {
        Self.register(URLSession.shared as NetworkRequestable)
        Self.register(UIKitApplication.shared as ExternalAppLaunching)
        Self.register(LocationsCoordinator() as LocationsCoordinating)
        Self.register(LocationsServiceImplementation() as LocationsService)
    }
}
