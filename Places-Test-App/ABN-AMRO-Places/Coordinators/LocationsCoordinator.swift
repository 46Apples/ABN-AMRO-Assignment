import Foundation
import OSLog

// A coordinator that encapsulates navigation to Wikipedia's [Places] deep link
struct LocationsCoordinator {
    @Inject private var appLauncher: ExternalAppLaunching
    private let logger = Logger(category: "\(LocationsCoordinator.self)")
}

// MARK: [LocationsCoordinating] adoption

extension LocationsCoordinator: LocationsCoordinating {
    @MainActor func navigate(to location: LocationsModel) {
        // Obtain the full URL to Wikipedia's [Places] deep link from the [WikipediaTarget] type, appending the location coordinates to it.
        guard let url = WikipediaTarget.places.appending(location),
            appLauncher.canOpen(url) else {
            logger.error("Could not launch the specified Wikipedia Places URL")
            
            return
        }
        
        appLauncher.open(url)
    }
}

#if DEBUG

// MARK: Factory methods

extension LocationsCoordinator {
    // A factory method to create an instance of the coordinator for testing, using a mocked app (url) launcher instance.
    static func createTestInstance(
        appLauncher: ExternalAppLaunching
    ) -> LocationsCoordinator {
        var result = LocationsCoordinator()
        
        result.set(appLauncher)
        
        return result
    }
    
    private mutating func set(_ appLauncher: ExternalAppLaunching) {
        self.appLauncher = appLauncher
    }
}

#endif
