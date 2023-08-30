//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Nazarii Zomko on 19.09.2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            // managedObjectContext is effectively live versions of your data
        }
    }
}
