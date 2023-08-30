//
//  Extensions.swift
//  Habit
//
//  Created by Nazarii Zomko on 13.09.2022.
//

import SwiftUI

extension UIColor {
    struct HabitColors {
        static let yellow = UIColor(red: 1.00, green: 0.89, blue: 0.43, alpha: 1.00)
        static let purple = UIColor(red: 0.55, green: 0.47, blue: 0.93, alpha: 1.00)
        static let cyan = UIColor(red: 0.32, green: 0.82, blue: 0.94, alpha: 1.00)
        static let pink = UIColor(red: 0.99, green: 0.60, blue: 0.70, alpha: 1.00)
        static let red = UIColor(red: 0.98, green: 0.45, blue: 0.41, alpha: 1.00)
        static let orange = UIColor(red: 0.99, green: 0.66, blue: 0.44, alpha: 1.00)
        static let jasmine = UIColor(red: 0.85, green: 0.93, blue: 0.41, alpha: 1.00)
        static let green = UIColor(red: 0.33, green: 0.95, blue: 0.63, alpha: 1.00)
        static let blue = UIColor(red: 0.29, green: 0.57, blue: 1.00, alpha: 1.00)
    }
}


// Makes UIColor Codable - https://stackoverflow.com/a/50934846
@propertyWrapper
struct CodableColor {
    var wrappedValue: UIColor
}

extension CodableColor: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        guard let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid color")
        }
        wrappedValue = color
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let data = try NSKeyedArchiver.archivedData(withRootObject: wrappedValue, requiringSecureCoding: true)
        try container.encode(data)
    }
}


// Adds the ability to change placeholder color - https://stackoverflow.com/a/62950092
struct PlaceHolder<T: View>: ViewModifier {
    var placeHolder: T
    var show: Bool
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if show { placeHolder }
            content
        }
    }
}

extension View {
    func placeHolder<T:View>(_ holder: T, show: Bool) -> some View {
        self.modifier(PlaceHolder(placeHolder:holder, show: show))
    }
}
