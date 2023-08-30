//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Nazarii Zomko on 19.08.2022.
//

import SwiftUI

struct ProminentTile: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentTitleStyle() -> some View {
        modifier(ProminentTile())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .prominentTitleStyle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
