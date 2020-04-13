//
//  AddressDetail.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 4/10/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation

enum AddressDetail {
    case name, street, unit, city, state, zip, phone

    var placeHolder: String {
        switch self {
        case .name:
            return "Name"
        case .street:
            return "Street address or P.O.Box"
        case .unit:
            return "Apt, Suit, Unit, Building (optional)"
        case .city:
            return "City"
        case .state:
            return "State/Province/Region"
        case .zip:
            return "ZIP"
        case .phone:
            return "Phone"
        }
    }
}
