import Foundation

// [NetworkRequestable] defines the same [data(:)] method signature as in [URLSession] to allow [URLSession] to adopt the protocol, and therefore register it as the implementing type in the Dependency Container.
protocol NetworkRequestable {
    func data(
        for request: URLRequest
    ) async throws -> (Data, URLResponse)
}
