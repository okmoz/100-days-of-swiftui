//
//  Location.swift
//  BucketList
//
//  Created by Nazarii Zomko on 28.09.2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID // needs to be var instead of let because new location will not be saved due to having the same id; so to fix this problem, we'll need make this property var and create a location with a completely new id.
    var name: String
    var description: String
    let latitude: Double
    let longtitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }
    
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Some description about the palace", latitude: 51.501, longtitude: -0.141)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
