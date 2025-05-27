import SwiftUI

@main
struct PlacesApp: App {
    
    init() {
        // Register all required dependencies with the Dependency Container when the app is initialised.
        registerDependenciesWithContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            LocationsHomeView()
                .environment(\.locationsViewModel, LocationsHomeViewModel())
        }
    }
}

// MARK: Private

extension PlacesApp {
    private func registerDependenciesWithContainer() {
        DependencyContainer.registerDependencies()
    }
}
