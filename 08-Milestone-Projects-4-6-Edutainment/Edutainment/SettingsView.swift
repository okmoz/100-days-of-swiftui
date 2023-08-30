//
//  SettingsView.swift
//  Edutainment
//
//  Created by Nazarii Zomko on 27.08.2022.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isSettingsShowing: Bool
    @Binding var settings: (tableUpTo: Int, numberOfQuestions: Int)
    
    var body: some View {
        Button("Start Game") {
            isSettingsShowing.toggle()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isSettingsShowing: .constant(true), settings: .constant((tableUpTo: 2, numberOfQuestions: 10)))
    }
}
