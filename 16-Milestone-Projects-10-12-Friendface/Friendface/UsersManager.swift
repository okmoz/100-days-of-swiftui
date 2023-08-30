//
//  UsersManager.swift
//  Friendface
//
//  Created by Nazarii Zomko on 21.09.2022.
//

import SwiftUI

class UsersManager: ObservableObject {
    @Published var users = [User]()
    var dataController = DataController()
    
//    init(users: [User]) {
//        self.users = users
//    }
    
    init() { }
    
    // _ completion: () async -> () = {}
    
    func getUsersFromAPI() async -> [User]? {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedUsersArray = try? decoder.decode([User].self, from: data) {
                return decodedUsersArray
            }
        } catch {
            print("Error: \(error)")
            return nil
        }
        
        return nil
    }
    
//    private func getUsersFromCache() async -> [User]? {
//
//
//
//        return []
//    }
    
//    private func saveUsersToCache() {
//
//    }
//
//    func loadUsers() async {
//        if let cachedUsers = await getUsersFromCache() {
//            await MainActor.run {
//                users = cachedUsers
//            }
//        }
//
//        if let usersFromAPI = await getUsersFromAPI() {
//            await MainActor.run {
//                users = usersFromAPI
//                saveUsersToCache() // how to save on bg thread?
//            }
//        }
//    }
    
    func getUser(id: UUID) -> User? {
        return users.first { $0.id == id }
    }
}
