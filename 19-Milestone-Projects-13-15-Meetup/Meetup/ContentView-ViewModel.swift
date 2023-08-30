//
//  ContentView-ViewModel.swift
//  Meetup
//
//  Created by Nazarii Zomko on 01.10.2022.
//

import PhotosUI
import SwiftUI
import CoreLocation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var people: [Person]
        @Published var selectedPhotosPickerItem: PhotosPickerItem? = nil
        @Published var selectedImageData: Data? = nil
        @Published var selectedImageName: String = ""
        @Published var isAddNameAlertShowing = false
        
        let locationFetcher = LocationFetcher()
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addPerson() {
            Task {
                if let data = try? await selectedPhotosPickerItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                    if let selectedImageData = selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                        let currentLocation = locationFetcher.getLocation()
                        let newPerson = Person(id: UUID(), name: selectedImageName, image: uiImage, photoLatitude: currentLocation.latitude, photoLongtitude: currentLocation.longtitude)
                        people.insert(newPerson, at: 0)
                        save()
                    }
                }
            }
        }
        

        
        func update(person: Person) {
            if let index = people.firstIndex(of: person) {
                people[index] = person
                save()
            }
        }
        
        func remove(at offsets: IndexSet) {
            people.remove(atOffsets: offsets)
            save()
        }
        
    }
}
