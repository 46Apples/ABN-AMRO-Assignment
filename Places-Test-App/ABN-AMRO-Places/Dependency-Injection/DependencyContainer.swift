// A simple custom Dependency Injection Container to register concrete implementations for given abstractions (in the form of protocols)
final class DependencyContainer {
    private var dependencies = [String: Any]()
    private static var shared = DependencyContainer()
    
    static func register<T>(_ dependency: T) {
        shared.register(dependency)
    }
    
    static func resolvedDependency<T>() -> T {
        shared.resolve()
    }
}

// MARK: Private methods

extension DependencyContainer {
    private func register<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency as Any
    }
    
    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key] as? T
        
        precondition(dependency != nil, "No dependency was registered for \(key)! Please register the appropriate dependency before calling resolve.")
        
        return dependency!
    }
}
