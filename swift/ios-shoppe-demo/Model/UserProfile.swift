//
//  UserProfile.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 4/30/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation

class UserProfile {
    var name: String
    var street: String
    var phone: String

    init(addressDetail: [AddressDetail: String]) {
        self.name = addressDetail[.name] ?? ""
        self.street = addressDetail[.street] ?? ""
        self.phone = addressDetail[.phone] ?? ""
    }

    func description() -> String {
        return "\(name)/n\(street)/n\(phone)"
    }
}
