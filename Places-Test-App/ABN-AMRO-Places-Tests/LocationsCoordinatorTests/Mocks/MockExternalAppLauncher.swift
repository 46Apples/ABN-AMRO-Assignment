import Foundation
@testable import ABN_AMRO_Places

final class MockExternalAppLauncher {
    private(set) var didInvokeCanOpen = false
    private(set) var didInvokeOpen = false
    private var actualUrl: URL?
    private var stubbedResult = false
    
    // Inject a stubbed result that the mock should return upon completion.
    init(stubbedResult: Bool) {
        self.stubbedResult = stubbedResult
    }
    
    func resetForTesting() {
        didInvokeCanOpen = false
        didInvokeOpen = false
        actualUrl = nil
    }
    
    // Helper method for tests to assert that the [canOpen(:)] method was invoked with the expected URL.
    func didInvokeCanOpen(with url: URL) -> Bool {
        didInvokeCanOpen && url == actualUrl
    }
    
    // Helper method for tests to assert that the [open(:)] was invoked with the expected URL.
    func didInvokeOpen(with url: URL) -> Bool {
        didInvokeOpen && url == actualUrl
    }
}

// MARK: [ExternalAppLaunching] adoption

extension MockExternalAppLauncher: ExternalAppLaunching {
    func canOpen(_ url: URL) -> Bool {
        didInvokeCanOpen = true
        
        actualUrl = url
        
        return stubbedResult
    }
    
    func open(_ url: URL) {
        didInvokeOpen = true
        
        actualUrl = url
    }
}
