//
//  Order.swift
//  ios-shoppe-demo
//
//  Created on 3/31/20.
//  Copyright © 2020 FullStory. All rights reserved.
//

import Foundation

class Order {
    var items: [Product] = []
    var date: Date = Date()
    var orderId: String = makeId(len: 9)
    var shipping: Double = 5.99
    var tax: Double = 2.85
    var cartOrderTotal: Double {
        return items.reduce(0, { $0 + getTotal(for: $1) })
    }

    func addProduct(_ productName: String ) {
        items.filter { $0.title == productName }.first?.quantity += 1
    }
    
    func getProduct(_ productName: String ) -> Product? {
        return items.filter { $0.title == productName }.first
    }

    func orderSummary() -> [String: Any] {
        let sortedItems: [Product] = items.filter { $0.quantity > 0 }
        var orderDict: [String: Any] = [:]

        for item in sortedItems {
            orderDict[item.title] = item.quantity
        }
        
        orderDict["order_id_str"] = orderId
        orderDict["revenue_real"] = cartOrderTotal
        orderDict["shipping_real"] = shipping
        orderDict["tax_real"] = tax

        return orderDict
    }
}
