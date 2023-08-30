//
//  ContentView.swift
//  Drawing2
//
//  Created by Nazarii Zomko on 02.09.2022.
//

import SwiftUI

struct Arrow: Shape {
    var thiccness: Double = 1
    
    var animatableData: Double {
        get { thiccness }
        set { thiccness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let triangleHeight = rect.maxY / 3
        let triangleWidth = triangleHeight * thiccness
        let rectangleWidth = triangleWidth / 6
        let rectangleHeight = rect.maxY - triangleHeight
        
        let arrowPath = Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.midX - triangleWidth / 2, y: triangleHeight))
            p.addLine(to: CGPoint(x: rect.midX + triangleWidth / 2, y: triangleHeight))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            p.closeSubpath()
            
            p.addRect(CGRect(x: rect.midX - rectangleWidth / 2, y: triangleHeight, width: rectangleWidth, height: rectangleHeight))
        }
        
        return arrowPath
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                                
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct ContentView: View {
    @State private var arrowThiccness: Double = 1
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack() {
            Arrow(thiccness: arrowThiccness)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation {
                        arrowThiccness = arrowThiccness == 1 ? 2 : 1
                    }
                }
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 300)
            Slider(value: $colorCycle)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
