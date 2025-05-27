struct LocationResponse: Decodable, Equatable {
    let name: String?
    let lat: Double
    let long: Double
}
