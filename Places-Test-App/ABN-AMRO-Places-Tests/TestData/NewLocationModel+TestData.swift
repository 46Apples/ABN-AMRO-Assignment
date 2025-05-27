@testable import ABN_AMRO_Places

// [NewLocationModel] test data.

extension NewLocationModel {
    static var mockEmptyNewLocation: NewLocationModel {
        .init()
    }
    
    static var mockNewLocation: NewLocationModel {
        .init(name: "Mock Location Name", lattitude: 123.456, longitude: 456.789)
    }
}
