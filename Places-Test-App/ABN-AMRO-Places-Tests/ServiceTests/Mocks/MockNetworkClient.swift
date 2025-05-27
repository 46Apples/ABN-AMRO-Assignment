import Foundation
@testable import ABN_AMRO_Places

// Subclasses [MockStub] in order to get access to generic stubbed responses from the mock.
// [T] is used to inform [MockStub] what data type it should create a stubbed response for.
class MockNetworkClient<T: Any>: MockStub<T> {
    private(set) var actualRequest: URLRequest?
    
    func resetForTesting() {
        super.reset()
        
        actualRequest = nil
    }
    
    // Helper method for tests to assert that the [data(:)] method was invoked with the expected URL and httpMethod.
    func wasInvoked(with url: URL, httpMethod: String) -> Bool {
        actualRequest?.url == url
        && actualRequest?.httpMethod == httpMethod
    }
}

// MARK: [NetworkRequestable] adoption

extension MockNetworkClient: NetworkRequestable {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        actualRequest = request
        
        guard let result = stubbedResult else { throw MockError.error }
        
        switch result {
        case .success(let value):
            guard let value = value as? Data else { throw MockError.error }
            return (value, URLResponse())
        case .failure(let error):
            throw error
        }
    }
}
