import Foundation

// A type that encapsulates the [Wikipedia] deep link configuration values, to ensure all related configuration values are located in one place.
enum WikipediaTarget {
    case places
}

extension WikipediaTarget {
    var url: URL {
        switch self {
        case .places:
            return URL(string: "wikipedia://places")!
        }
    }
}

extension WikipediaTarget {
    // Append the specified location coordinates to the [Wikipedia] deep link URL as query items.
    func appending(_ location: LocationsModel) -> URL? {
        WikipediaTarget.places.url.appending(
            queryItems: [
                .init(name: "lattitude", value: "\(location.lattitude)"),
                .init(name: "longitude", value: "\(location.longitude)")
            ]
        )
    }
}
