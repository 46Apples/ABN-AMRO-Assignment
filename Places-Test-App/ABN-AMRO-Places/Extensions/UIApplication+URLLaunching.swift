import UIKit

// Prevent having to import [UIKit] at call sites
typealias UIKitApplication = UIApplication

// An abstraction over the URL opening api provided by [UIApplication]. The abstration decouples the call sites from knowledge of [UIApplication.shared], and also allows for injecting test doubles for consumers in their test suites to easily assert expected behaviour.
protocol ExternalAppLaunching {
    func canOpen(_ url: URL) -> Bool
    
    @MainActor func open(_ url: URL)
}

extension UIApplication: ExternalAppLaunching {
    func canOpen(_ url: URL) -> Bool {
        UIApplication.shared.canOpenURL(url)
    }
    
    func open(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
