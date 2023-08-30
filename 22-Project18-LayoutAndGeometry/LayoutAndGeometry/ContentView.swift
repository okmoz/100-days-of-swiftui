//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Nazarii Zomko on 12.10.2022.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader {geo in
                        let color = Color(hue: min(1, geo.frame(in: .global).minY / fullView.size.height), saturation: 1, brightness: 1)
                        
                        Text("Row #\(index), geo: \(geo.frame(in: .global).minY), full: \(fullView.size.height)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
//                            .background(colors[index % 7])
                            .background(color) // challenge 3
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(geo.frame(in: .global).minY / 200) // challenge 1
                            .scaleEffect(max(0.5, geo.frame(in: .global).minY / fullView.size.height)) // challenge 2
                    }
                    .frame(height: 40)
                }
            }
            //            .mask(LinearGradient(gradient: Gradient(colors: [.clear, .white, .white]), startPoint: .top, endPoint: .bottom))
//            .mask(LinearGradient(stops: [
//                Gradient.Stop(color: .clear, location: .zero),
//                Gradient.Stop(color: .red, location: 0.2)],
//                                 startPoint: .top,
//                                 endPoint: .bottom
//                                )
//            )
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
