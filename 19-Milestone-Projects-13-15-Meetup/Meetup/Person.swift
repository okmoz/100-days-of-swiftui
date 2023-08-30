//
//  Person.swift
//  Meetup
//
//  Created by Nazarii Zomko on 01.10.2022.
//

import SwiftUI
import CoreLocation

struct Person: Identifiable, Codable, Equatable {
    enum CodingKeys: CodingKey {
        case id, name, image, photoLatitude, photoLongtitude
    }
    
    var id: UUID
    var name: String
    var image: UIImage
    var photoLatitude: Double?
    var photoLongtitude: Double?
    
    var coordinate: CLLocationCoordinate2D? {
        if let photoLatitude, let photoLongtitude {
            return CLLocationCoordinate2D(latitude: photoLatitude, longitude: photoLongtitude)
        } else {
            return nil
        }
    }
    
    init(id: UUID, name: String, image: UIImage, photoLatitude: Double?, photoLongtitude: Double?) {
        self.id = id
        self.name = name
        self.image = image
        self.photoLatitude = photoLatitude
        self.photoLongtitude = photoLongtitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let imageData = try container.decode(Data.self, forKey: .image)
        image = UIImage(data: imageData) ?? UIImage()
        photoLatitude = try container.decode(Double?.self, forKey: .photoLatitude)
        photoLongtitude = try container.decode(Double?.self, forKey: .photoLongtitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            try container.encode(imageData, forKey: .image)
        }
        try container.encode(photoLatitude, forKey: .photoLatitude)
        try container.encode(photoLongtitude, forKey: .photoLongtitude)
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = Person(id: UUID(), name: "John Doe", image: UIImage(systemName: "star")!, photoLatitude: 51.507222, photoLongtitude: -0.1275)
}
