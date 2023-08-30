//
//  ContentView.swift
//  Edutainment
//
//  Created by Nazarii Zomko on 26.08.2022.
//

// TODO: add settings view
// TODO: try creating a custom keyboard

import SwiftUI

struct ContentView: View {
    @State private var isSettingsShowing = true

    var body: some View {
        if isSettingsShowing {
            SettingsView(isSettingsShowing: $isSettingsShowing, settings: .constant((tableUpTo: 2, numberOfQuestions: 10)))
        } else {
            GameView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
