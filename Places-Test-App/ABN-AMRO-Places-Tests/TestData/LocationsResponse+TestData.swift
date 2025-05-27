@testable import ABN_AMRO_Places
import Foundation

// Raw [LocationsResponse] json test data.

extension Data {
    static var mockRawLocationsResponse: Data {
        Data("""
            {
              "locations": 
              [
                {
                  "name": "Amsterdam",
                  "lat": 52.3547498,
                  "long": 4.8339215
                },
                {
                  "name": "Mumbai",
                  "lat": 19.0823998,
                  "long": 72.8111468
                },
                {
                  "name": "Copenhagen",
                  "lat": 55.6713442,
                  "long": 12.523785
                },
                {
                  "lat": 40.4380638,
                  "long": -3.7495758
                }
              ]
            }    
            """.utf8
        )
    }
}

// Decoded [LocationsResponse] test data.

extension LocationsResponse {
    static var mockDecodedLocationsResponse: LocationsResponse {
        .init(
            locations: [
                .init(name: "Amsterdam", lat: 52.3547498, long: 4.8339215),
                .init(name: "Mumbai", lat: 19.0823998, long: 72.8111468),
                .init(name: "Copenhagen", lat: 55.6713442, long: 12.523785),
                .init(name: nil, lat: 40.4380638, long: -3.7495758)
            ]
        )
    }
}
