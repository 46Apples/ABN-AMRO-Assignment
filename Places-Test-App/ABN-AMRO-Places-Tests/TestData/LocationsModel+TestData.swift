@testable import ABN_AMRO_Places

// [LocationsModel] test data.

extension [LocationsModel] {
    static var mockLocations: [LocationsModel] {
        [
            .init(name: "Amsterdam", lattitude: 52.3547498, longitude: 4.8339215),
            .init(name: "Mumbai", lattitude: 19.0823998, longitude: 72.8111468),
            .init(name: "Copenhagen", lattitude: 55.6713442, longitude: 12.523785),
            .init(name: "Unknown Location", lattitude: 40.4380638, longitude: -3.7495758)
        ]
    }
    
    static var mockLocationsWithAddedItem: [LocationsModel] {
        mockLocations + [.mockLocation]
    }
}

extension LocationsModel {
    static var mockLocation: LocationsModel {
        .init(name: "Mock Location Name", lattitude: 123.456, longitude: 456.789)
    }
}
