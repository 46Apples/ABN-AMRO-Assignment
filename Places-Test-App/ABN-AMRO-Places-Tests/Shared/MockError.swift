import Foundation

enum MockError: Error {
    case error
}

extension MockError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .error: return "Mock error"
        }
    }
}
