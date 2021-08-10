//
//  SegmentAnalyticsManager.swift
//  ios-shoppe-demo
//
//  Created by FullStory on 6/15/20.
//  Copyright © 2020 FullStory. All rights reserved.
//

import Foundation

func trackProductAddedEvent(product: Product?){
    if let product = product {
        Analytics.shared().track("Product Added", properties: [
            "order_id":"2",
            "product_id": product.title,
            "description": product.description,
            "name": product.title,
            "price": product.price,
            "products":[
                ["test1":"test1"],
                ["test2":"test2"]
            ]
        ])
    }
}

func trackProductRemovedEvent(product: Product?){
    if let product = product {
        Analytics.shared().track("Product Removed", properties: [
            "product_id": product.title,
            "description": product.description,
            "name": product.title,
            "price": product.price,
            "quantity": 1
        ])
    }
}

func trackCartViewedEvent(order: Order){
    Analytics.shared().track("Cart Viewed", properties: [
            "cart_id": "d92jd29jd92jd29j92d92jd",
            "products":getPropsFromProductArray(products: order.items.filter { $0.quantity > 0 })
        ])
}

func trackCheckoutStartedEvent(order: Order){
    Analytics.shared().track("Checkout Started", properties: [
        "order_id": "50314b8e9bcf000000000000",
        "value": order.cartOrderTotal(),
        "currency": "USD",
        "products":getPropsFromProductArray(products: order.items.filter { $0.quantity > 0 })
    ])
}

func trackOrderCompletedEvent(order: Order){
    Analytics.shared().track("Order Completed", properties: [
        "checkout_id": "fksdjfsdjfisjf9sdfjsd9f",
        "order_id": "50314b8e9bcf000000000000",
        "subtotal": order.cartOrderTotal(),
        "value": order.cartOrderTotal(),
        "currency": "USD",
        "products":getPropsFromProductArray(products: order.items.filter { $0.quantity > 0 })
    ])
}

func getPropsFromProductArray(products: [Product]) -> [Any]{
    return products.map({ (product) -> Any in
        return [
            "product_id": product.title,
            "description": product.description,
            "name": product.title,
            "price": product.price,
            "quantity": 1
        ]
    })
}


