import Foundation

// A type that allows defining network request configurations in one place, to ensure all related configuration values are located in one place only.
enum ServiceTarget {
    case locations
}

extension ServiceTarget {
    var url: URL {
        switch self {
        case .locations:
            return URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json")!
        }
    }
    
    var httpMethod: String {
        switch self {
        case .locations: return "GET"
        }
    }
}
