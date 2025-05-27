protocol LocationsCoordinating {
    @MainActor func navigate(to location: LocationsModel)
}
