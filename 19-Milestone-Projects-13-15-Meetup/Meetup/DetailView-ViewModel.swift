//
//  DetailView-ViewModel.swift
//  Meetup
//
//  Created by Nazarii Zomko on 02.10.2022.
//

import SwiftUI
import MapKit

extension DetailView {
    class ViewModel: ObservableObject {
        @Published var person: Person
        @Published var isChangeNameAlertShowing = false
        
        @Published var mapRegion: MKCoordinateRegion
        
        init(person: Person) {
            self.person = person
            if let coordinate = person.coordinate {
                mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            } else {
                mapRegion = MKCoordinateRegion(center: Person.example.coordinate!, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            }
        }
    }
}
