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
    var shipping: Double = 5.99
    var tax: Double = 2.85
    var cartOrderTotal: Double {
        return items.reduce(0, { $0 + getTotal(for: $1) })
    }

    func setItems(items: [Product]){
        self.items.removeAll()
        items.forEach{ self.items.append($0) }
    }

    func getProduct(_ productName: String ) -> Product? {
        return items.first(where: { $0.title == productName })
    }

    func addProduct(_ productName: String ) {
        getProduct(productName)?.quantity += 1;
    }

    func getFilteredItems() -> [Product] {
        return items.filter{ $0.quantity > 0 }
    }

    func getNumberOfItems() -> Int{
        return getFilteredItems().reduce(0, { $0 + $1.quantity })
    }

    func resetOrder() {
        self.items.forEach{ $0.quantity = 0 }
    }

    // converting order to dictionary for FS events
    func orderSummary() -> [String: Any] {
        let filteredItems = getFilteredItems()
        var orderDict: [String: Any] = [:]

        for item in filteredItems {
            orderDict[item.title] = item.quantity
        }
        orderDict["revenue_real"] = cartOrderTotal
        orderDict["shipping_real"] = shipping
        orderDict["tax_real"] = tax

        return orderDict
    }
}
