//
//  Resort.swift
//  SnowSeeker
//
//  Created by Nazarii Zomko on 15.10.2022.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json") // static properties are lazy automatically, which means they will only be created when used
    static let example = allResorts[0] // swift will be forced to first create allResorts to use it here
}
