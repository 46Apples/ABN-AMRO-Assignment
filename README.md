# ABN AMRO iOS Assignment

This repository contains two iOS projects that have been developed or extended based on the requirements of a technical assignment to deep link into the Wikipedia app's **Places** tab from a test iOS app containing a list of locations fetched from the network. 

The first project is a **SwiftUI** test app that loads a list of locations from the network and shows them in a list using a very basic UI, and the second is a clone of the **Wikipedia** iOS project that has been updated to accomodate the deep linking from the test app.  

# Locations Test App

## Tech stack

* Language: **Swift**
* UI Framework: **SwiftUI**
* Testing Framework: **Swift Testing**
* Network Request Handling: **URLSession with async/await**

## Project configuration

* Xcode: **16.3**
* Swift: **6.1**
* Deployment Version: **iOS 18.4**

## Implementation

The application has been implemented using the **MVVM** architecture pattern and **Dependency Injection**.

The project (**Places-Test-App/ABN-AMRO-Places.xcodeproj**) contains two targets: the main **app target**, and a **unit test target**.  

The unit test target includes unit tests for the **view model**, **service**, **coordinator** and **DI Container** implementations, using the **mock object** pattern.

The entry point to the app is **PlacesApp.swift**. Here the required dependencies are registered in the Dependency Injection Container, and **LocationsHomeView** is presented to the user as the first view for the UI, with its view model injected using **@Environment**.

## Dependency Injection ##

The project contains a simple Dependency Injection implementation, **DependencyContainer.swift**, and together with a custom written property wrapper, **Inject.swift**, provides the ability to register concrete implementations for given abstractions (in the form of protocols), and then use the **@Inject** property wrapper to resolve the implementation in places that require access to the given dependencies.

## Locations Home View ##

**LocationsHomeView.swift** is the entry point to view a list of locations which are downloaded from https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json. 

The view exposes two behaviours to the user: adding a new location to the list of locations downloaded from the endpoint, and deep linking to the **Wikipedia** app when a location from the list is tapped.

Adding a new location is handled by tapping the **Add** button located on the navigation bar, which presents a form with input fields in a sheet for adding the new location.

When tapping on a location in the list, the user is navigated to the **Wikipedia** app, and deep linked into the **Places** tab, and the selected location is shown on a map view, given that the location coordinates are valid. 

The view handles rendering of the following view states (defined as an enum data type, with associated values for the **loaded** key):
* Loading
* Error
* Loaded

The view model sets the view state to **loading** when it starts the network request to fetch the locations, which presents a loading indicator to the user while the data is being fetched (the view model is marked with **@Observable**, meaning the view will render it's state when the value of the view state is mutated).

In the event that an error occurs during the network request, such as a network failure due to a poor or no network signal, a view is rendered for the **error** view state, informing the user that something went wrong, and a button to press to try the network request again.

If a list of locations is returned from the network request, a view is rendered to show the list of data as part of the view's **loaded** view state. The **loaded** view state is an enum key with an associated value for the list of returned locations.

Each of the views for the given view states are extracted as separate **SwiftUI** views.

## Locations View Model ##

The view model is implemented in **LocationsHomeViewModel.swift**. It exposes two public facing methods: one for fetching the initial list of locations from the network (**fetchLocations()**) using **async/await**, and one for adding a new location to the list of locations (**addLocation(:)**), and then sets the view state to the appropriate state.

The view model conforms to the **LocationsHomeViewModelling** protocol, which provides an abstraction layer and inverts the view's dependency on a concrete view model implementation. Further to that, there is also a fake view model included in the project, namely **FakeLocationsViewModel**, which can be used to swap out the production view model with a fake implementation so that the app is not depdendant on network connectivity while testing the app if needed.

The view model uses an implementation that conforms to the **LocationsService** protocol to perform the network request, which is registered in the Dependency Injection Container, and injected using the custom-written **@Inject** property wrapper, which resolves the implementation that is registered for the service protocol. This allows injecting test doubles during the unit tests to test the various scenarios.

At the bottom of the view model file is a section that is wrapped with an **#if DEBUG...#endif** pre-processor directive, as well as a factory method that is used to initialise the view model as a test instance for unit tests (found in **LocationsHomeViewModelTests.swift**). This convenience factory method is wrapped in a pre-processor directive in order to make it explicit that it ought to be used only to create a test instance, and not used in production code, as the view model should depend only on the injected service instance for making network requests. The same pattern is used in the service implementation type.

## Service / Network ##

The logic to make the network request to fetch the list of initial locations is implemented in **LocationsServiceImplementation.swift**. It makes use of **URLSession** under the hood to make the network request, which has been abstracted behind a protocol (**NetworkRequestable.swift**) and registered in the Dependency Container and then injected using the **@Inject** property wrapper. The reason for the abstraction is in order to be able to inject a mock / test double during unit tests for the service implementation. The mock is used to assert that the expected network endpoint was invoked with the expected URL and http method.

Initialisation of a **URLRequest** instance is encapsulated in a factory method, which builds up the request using the required url and http method type (GET).

As with the view model, there is an **#if DEBUG...#endif** pre-processor directive at the bottom of the service implementation for testability purposes. The unit tests for the service implementation are located in **LocationsServiceTests.swift**.

## Deep Linking Coordinator ##

A coordinator has been implemented to perform the deep linking into the **Wikipedia** app's **Places** tab. The coordinator is implemented in **LocationsCoordinator.swift**. The deep link URL, which includes the location's coordinates, is resolved using the **WikipediaTarget**, en enum declared in **WikipediaTarget.swift**, which contains all the configuration information required for the deep linking.

The coordinator is injected into **LocationsListView** from the Dependency Injection Conatainer, and is invoked when one of the locations in the list is tapped, which then performs the deep linking into the **Wikipedia** app.


# Wikipedia Project Updates

Updates have been made to the Wikipedia project to accomodate deep linking to the **Places** tab for given location coordinates. These updates are as follows.

## WMFAppViewController ##

The **WMFAppViewController** attempts to process and handle a given **NSUserActivity** instance in a method called **[(BOOL)processUserActivity:activity:animated:completion]**.

The **[processUserActivity]** method has been updated to check whether the given activity's **[wmf_mapCoordinates]** method returns location coordinate values that have been populated. If location coordinates are found, the **PlacesViewController** is presented, and **showLocation(latitude: Double, longitude: Double)** is invoked on it in order to show the location on the map view for the given coordinates.

As a side note, after having made the required changes to handle the location coordinates, I am of the opinion that the content and structure of the **[processUserActivity]** method can improved drastically by using something like the **Gang of Four's Command** pattern, or **Replace Conditional With Polymorphism** refactoring with a **Strategy** pattern to extract the content of the cases into command or strategy objects, to reducde the complexity and improve the readability of the method, as well as make it easier to add new behaviour to it in the future.    

## WMFMapRegionCoordinates ##

The custom type **WMFMapRegionCoordinates** has been added to the project to combine the longitude and lattitude coordinates in a single object, with a helper method to indicate whether the object cantains initialised coordinates (i.e., **[(BOOL) isValid]**).

## PlacesViewController ##

The **PlacesViewController** view controller is used to show locations on a map, using a **MapView** instance. 

A new method with the signature (**showLocation(latitude: Double, longitude: Double)**) has been added to the view controller, and is used from **WMFAppViewController** to ask **PlacesViewController** to load the given coordinates in its **MapView**. 

The **showLocation(::)** method attempts to initialise an **CLLocationCoordinate2D** instance using the given location coordinates. If it fails to do so, due to invalid region coordinates for example, the error is logged, and execution of the method is aborted. It also invokes **loadViewIfNeeded()** at the beginning of the method to ensure that the view controller's properties are initialised before attempting to access any of them when setting the location on the map. 

## NSUserActivity (WMFExtensions) Category ##

The method signature **[(WMFMapRegionCoordinates)wmf_mapCoordinates]** has been added to the **NSUserActivity (WMFExtensions)** category, which is referenced from **WMFAppViewController** to obtain the longitude and lattitude coordinates from the **WMFMapRegionCoordinates** object. Internally, the **[wmf_mapCoordinates]** method uses the **Associative Storage** pattern to read the location coordinates from the **UserInfo** dictionary, which appears to be the approach used for sharing data between different objects in the project. 

The **[(instancetype)wmf_placesActivityWithURL:(NSURL)activityURL]** method has also been updated to parse the location coordinates from the URL parameter's query items, if present. Location coordinates are passed to the Wikipedia app's **Places** deep link via the scheme's URL, and are extracted here and stored in the **Place** activity's **UserInfo** dictionary, preserving any other data that may already be in the dictionary. 

## Wikipedia Places Deep Link URL Tests ##

Two tests have been added to the existing **NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test** test suite that tests the deep link behaviour for the **Places** destination.

The first test, **[testPlacesURLWithoutCoordinates]**, asserts that the **NSUserActivity** instance returned from the **[wmf_activityForWikipediaScheme]** method call contains only the **Places** item in the **UserInfo** dictionary when no coordinates are passed to the **wikipedia://places** scheme.

The second test, **[testPlacesURLWithCoordinates]**, asserts that in addition to the **Places** item, the **NSUserActivity** instance also contains the expected location coordinates in the **UserInfo** dictionary. 
