//
//  Utilities.swift
//  ios-shoppe-demo
//
//  Created on 3/9/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation

func getPlist(withName name: String) -> [String: String]? {
    if let path = Bundle.main.path(forResource: name, ofType: "plist"),
        let xml = FileManager.default.contents(atPath: path) {
        return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String: String]
    }

    return nil
}
