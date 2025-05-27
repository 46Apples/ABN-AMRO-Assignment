// A type that defines the valid view states for the locations screen.
enum LocationsHomeViewState: Equatable {
    case loading
    case error
    case loaded(locations: [LocationsModel]) // The [loaded] case includes an associated type in which the list of locations is returned to the caller.
}
