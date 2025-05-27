import Foundation

extension URLRequest {
    // Factory method to create a [URLRequest] instance configured using a given [ServiceTarget].
    static func create(for target: ServiceTarget) -> URLRequest {
        var result = URLRequest(url: target.url)
        
        result.httpMethod = target.httpMethod
        
        return result
    }
}
