import Foundation

// [NetworkRequestable] is an abstraction for [URLSession]. The [NetworkRequestable] protocol exposes the method signature used in the app that matches that defined in [URLSession]. Adding a conformance to [NetworkRequestable] for [URLSession] allows types that depend on making service requests to provide test doubles in their test suites to easily verify expected behaviour on the network client without actually making the network request.
extension URLSession: NetworkRequestable { }
