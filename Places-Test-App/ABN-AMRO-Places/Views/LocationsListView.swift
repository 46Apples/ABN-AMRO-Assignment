import SwiftUI

// Represents the UI for rendering the list of locations injected into the [Environment].
struct LocationsListView: View {
    @Inject private var coordinator: LocationsCoordinating
    @Environment(\.locationListModel) private var locations: [LocationsModel]
    @State private var newLocationModel = NewLocationModel()
    @State private var showingSheet = false
    private let newLocationAction: (NewLocationModel) -> Void
    
    init(newLocationAction: @escaping (NewLocationModel) -> Void) {
        self.newLocationAction = newLocationAction
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(locations, id: \.name) { location in
                    VStack(alignment: .leading) {
                        Text(location.name)
                            .font(.title)
                        HStack {
                            Text("Lattitude:")
                            Text("\(location.lattitude)")
                        }
                        HStack {
                            Text("Longitude:")
                            Text("\(location.longitude)")
                        }
                    }
                    .onTapGesture {
                        handleSelection(of: location)
                    }
                }
            }
            .navigationTitle("Places")
            .toolbar {
                Button("Add") {
                    showingSheet.toggle()
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            Text("New Location")
                .font(.title)
                .padding()
            
            Form {
                Section {
                    TextField("Location Name", text: $newLocationModel.name)
                    // Ideally these [TextField] inputs should be updated to use a formatter that allows only numeric input and other special characters used for location coordinates, such as [-] and [,]
                    TextField("Lattitute", value: $newLocationModel.lattitude, format: .number)
                    TextField("Longitude", value: $newLocationModel.longitude, format: .number)
                }
                
                Section {
                    Button("Add") {
                        addNewLocation()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .presentationDetents([.medium])
        }
    }
}

// MARK: Private [LocationsListView]

extension LocationsListView {
    private func handleSelection(of location: LocationsModel) {
        // Perform the deep link into the Wikipedia app's [Places] tab using the coordinator.
        coordinator.navigate(to: location)
    }
    
    private func addNewLocation() {
        newLocationAction(newLocationModel)
        
        finaliseTasks()
    }
    
    private func finaliseTasks() {
        toggleSheetStatus()
        
        resetNewLocationModel()
    }
    
    private func toggleSheetStatus() {
        showingSheet.toggle()
    }
    
    private func resetNewLocationModel() {
        // Reset the new location model so that no previous data is shown when the sheet is presented again.
        newLocationModel = .init()
    }
}

#Preview {
    LocationsListView(newLocationAction: { _ in })
        .environment(\.locationListModel, .exampleLocations)
}
