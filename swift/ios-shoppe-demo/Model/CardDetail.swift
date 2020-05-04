//
//  CardDetail.swift
//  ios-shoppe-demo
//
//  Created on 4/13/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation

enum CardDetail {
    case name, cardNumber, expiration, csv

    var placeHolder: String {
        switch self {
        case .name:
            return "Name on card"
        case .cardNumber:
            return "Card number"
        case .expiration:
            return "01/2020"
        case .csv:
            return "000"
        }
    }
}
