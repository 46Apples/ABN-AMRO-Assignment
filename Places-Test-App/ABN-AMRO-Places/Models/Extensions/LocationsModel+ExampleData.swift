#if DEBUG

// Some fake data that can be used in SwiftUI view previews that render lists of [LocationsModel] instances.
extension [LocationsModel] {
    static var exampleLocations: [LocationsModel] {
        [
            .init(name: "Amsterdam", lattitude: 52.3547498, longitude: 4.8339215),
            .init(name: "Mumbai", lattitude: 19.0823998, longitude: 72.8111468),
            .init(name: "Copenhagen", lattitude: 55.6713442, longitude: 12.523785)
        ]
    }
}

#endif
