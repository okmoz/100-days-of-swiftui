//
//  User.swift
//  Friendface
//
//  Created by Nazarii Zomko on 20.09.2022.
//

import Foundation
//
//struct Response: Codable {
//    var users: [User]
//}

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}
