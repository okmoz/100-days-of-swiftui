//
//  FriendfaceApp.swift
//  Friendface
//
//  Created by Nazarii Zomko on 20.09.2022.
//

import SwiftUI

@main
struct FriendfaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
