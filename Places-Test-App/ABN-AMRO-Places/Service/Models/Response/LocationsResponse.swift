// Model to store the decoded response from the locations network request.
struct LocationsResponse: Decodable, Equatable {
    let locations: [LocationResponse]
}
