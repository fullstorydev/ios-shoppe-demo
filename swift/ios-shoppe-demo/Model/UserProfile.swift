//
//  UserProfile.swift
//  ios-shoppe-demo
//
//  Created on 4/30/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation

class UserProfile {
    var id: UUID
    var name: String
    var email:String
    var street: String
    var phone: String

    var infoDict: [String: String] {
        return ["id":id.uuidString, "email":email]
    }

    init(addressDetail: [AddressDetail: String]) {
        self.name = addressDetail[.name] ?? ""
        self.street = addressDetail[.street] ?? ""
        self.phone = addressDetail[.phone] ?? ""
        self.email = addressDetail[.email] ?? ""
        self.id = UUID()
    }
}
