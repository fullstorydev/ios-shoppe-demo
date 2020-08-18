//
//  Order.swift
//  ios-shoppe-demo
//
//  Created on 3/31/20.
//  Copyright © 2020 FullStory. All rights reserved.
//

import Foundation

class Order {
    var items: [String: Product] = [:]
    var date: Date = Date()
    var orderId: String = makeId(len: 9)
    var shipping: Double = 5.99
    var tax: Double = 2.85
    var cartOrderTotal: Double {
        return items.reduce(0, { $0 + getTotal(for: $1.value) })
    }

    func addItems(items: [Product]){
        for item in items {
            self.items[item.title] = item
        }
    }

    func addProduct(_ productName: String ) {
        items[productName]?.quantity += 1
    }

    func getProduct(_ productName: String ) -> Product? {
        return items[productName]
    }

    func getFilteredItems() -> [Product] {
        return items
            .filter{ $0.value.quantity > 0 }
            .map{ $0.value }
    }

    func getNumberOfItems() -> Int{
        return getFilteredItems().reduce(0, { $0 + $1.quantity })
    }

    func resetOrder() {
        self.items.forEach{ $0.value.quantity = 0 }
        self.orderId = makeId(len: 9)
    }

    // converting order to dictionary for FS events
    func orderSummary() -> [String: Any] {
        let filteredItems = getFilteredItems()
        
        var orderDict: [String: Any] = [:]

        for item in filteredItems {
            orderDict[item.title] = item.quantity
        }
        
        orderDict["order_id_str"] = orderId
        orderDict["revenue_real"] = cartOrderTotal
        orderDict["shipping_real"] = shipping
        orderDict["tax_real"] = tax

        return orderDict
    }
}
