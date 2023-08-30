//
//  FileManager-DocumentsDirectory.swift
//  Meetup
//
//  Created by Nazarii Zomko on 02.10.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
