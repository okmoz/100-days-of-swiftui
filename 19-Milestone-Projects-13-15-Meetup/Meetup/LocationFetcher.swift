//
//  LocationFetcher.swift
//  Meetup
//
//  Created by Nazarii Zomko on 03.10.2022.
//

import Foundation
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        start()
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
    
    func getLocation() -> (latitude: Double?, longtitude: Double?) {
        if let location = lastKnownLocation {
            return (location.latitude, location.longitude)
        } else {
            print("Error: Could not fetch the location.")
            return (nil, nil)
        }
    }
}
