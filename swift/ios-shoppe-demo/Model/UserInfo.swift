//
//  UserInfo.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 4/17/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation

struct UserInfo {
    // AddressDetail
    var name: String
    var street: String
    var unit: String
    var city: String
    var state: String
    var zip: String
    var phone: String

    func description() -> String {
        return name + "\n" + street + "\n" + unit + "\n" + state + "\n" + zip + "\n" + phone
    }
}
