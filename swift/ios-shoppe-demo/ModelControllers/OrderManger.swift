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
        if currentOrder == nil {
            currentOrder = Order()
        }
        
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

    func getCostForProduct(_ prodName: String) -> Double? {
        return currentOrder?.items.filter { $0.title == prodName }.first?.price
    }

    func cartOrderTotal() -> Double {
        var cost = Double()
        updateItemQuantity()
        self.itemQuantities.forEach { (item, quantity) in
            if let price = getCostForProduct(item) {
                print("Adding price for product \(item)")
                print("num of \(item):\(quantity), price: \(price)")
                cost += price.multiply(quantity)
                print("\(cost)")
            }
        }

        return cost
    }
}
