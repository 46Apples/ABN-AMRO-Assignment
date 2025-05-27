import SwiftUICore

// Extension to register shared objects accessed using the [@Environment] property wrapper.
extension EnvironmentValues {
    @Entry var locationsViewModel: LocationsHomeViewModelling = LocationsHomeViewModel()
    @Entry var locationListModel: [LocationsModel] = []
}
