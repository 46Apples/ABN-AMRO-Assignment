extension LocationsResponse {
    // Helper method to transform a [LocationsResponse] service response to a list of [LocationsModel] instances consumed in the UI.
    func parse() -> [LocationsModel] {
        locations.reduce(into: [LocationsModel](), { result, element in
            result.append(
                .init(
                    name: element.name ?? "Unknown Location",
                    lattitude: element.lat,
                    longitude: element.long
                )
            )
        })
    }
}
