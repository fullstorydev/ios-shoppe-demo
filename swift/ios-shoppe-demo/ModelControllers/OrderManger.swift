//
//  OrderManger.swift
//  ios-shoppe-demo
//
//  Created on 4/1/20.
//  Copyright © 2020 FullSTory All rights reserved.
//

import Foundation

class OrderManager {
    static var sharedInstance = OrderManager()

    var currentOrder: Order?
    var itemQuantities = [String: Int]()

    func addProduct(_ product: Product) {
        currentOrder?.items.append(product)
        updateItemQuantity()
    }

    func orderEventLog() -> [String: Any] {
        var eventDict = [String: Any]()

        updateItemQuantity()

        eventDict["User"] = username
        eventDict["Date"] = currentOrder?.date
        eventDict["Cart"] = itemQuantities

        return eventDict
    }

    func updateItemQuantity() {
        var productTypes = [String]()
        currentOrder?.items.forEach { (product) in
            if !productTypes.contains(product.title) {
                productTypes.append(product.title)
                itemQuantities[product.title] = 1
            }
            else {
                if (itemQuantities[product.title] != nil) {
                    itemQuantities[product.title]! += 1
                }
            }
        }
    }
}
