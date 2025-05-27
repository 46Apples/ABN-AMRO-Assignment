@MainActor
protocol LocationsHomeViewModelling {
    var viewState: LocationsHomeViewState { get }
    
    func fetchLocations() async
    
    func addLocation(using model: NewLocationModel)
}
