//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Nazarii Zomko on 29.09.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
