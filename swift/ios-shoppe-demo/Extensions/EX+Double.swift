//
//  EX+Double.swift
//  ios-shoppe-demo
//
//  Created on 4/7/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation

extension Decimal {
    func multiply(_ byNumber: Int) -> Decimal {
        return self * Decimal(integerLiteral: byNumber)
    }
}
