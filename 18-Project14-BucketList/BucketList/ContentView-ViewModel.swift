//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Nazarii Zomko on 29.09.2022.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject { // if you're not sure whether to use @MainActor: every time you have a class that conforms to ObservableObject, add @MainActor
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var isShowingAuthenticationFailedAlert = false
        @Published var authenticationAlertMessage = ""
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection]) // "It's quite remarkable that all it takes to ensure the file is stored with strong encryption is to add .completeFileProtection to our options." -Paul
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longtitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places." // used for TouchID, whereas the reason for FaceID is inside a plist
                
                // this is done on a background thread outside of our app and thus will trigger a purple warning saying "Publishing changes from background threads is not allowed". To make sure we update our UI on the main thread, add a Task with MainActor.run, OR even a better way would be: Task { @MainActor in ... }
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    Task { @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else {
                            self.authenticationAlertMessage = "An error occurred: \(authenticationError?.localizedDescription ?? "ERROR DESCRIPTION")"
                            self.isShowingAuthenticationFailedAlert = true
                            // error
                        }
                    }
                }
            } else {
                self.authenticationAlertMessage = "An error occurred: \(error?.localizedDescription ?? "ERROR_DESCRIPTION")"
                self.isShowingAuthenticationFailedAlert = true
                // no biometrics
            }
        }
    }
}

// How is MVVM code structure better? Having properties and methods in a separate class makes it much easier to write tests for your code.
// private(set) means reading your data is fine but only the class itself can now write it
