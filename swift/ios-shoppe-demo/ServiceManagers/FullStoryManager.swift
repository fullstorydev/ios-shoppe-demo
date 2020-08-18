//
//  FullStoryManager.swift
//  ios-shoppe-demo
//
//  Created 5/7/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import FullStory

/*
FullStory Manager provides common functions and artifacts that make it easier to integrate FullStory into your iOS app.
    - Events
    - LogLevel
    - Identifying a user
    - create events
    - PrivacySetting: EXCLUDE, MASK, and UNMASK elements
 */

/// The Event enum represents major events in an iOS app. These may differ based on your particular app.
enum Event: String {
    // TODO: add string values for all events
    case addToCart = "Product Added"
    case browsing
    case checkout = "Order Completed"
    case crash
    case itemSelected
    case removeFromCart = "Product Removed"
    case viewCart
    case checkoutError = "Checkout Error"
}

enum LogLevel {
    case assert, debug, error, info, warning
}

/**
 For the hardcoded values that represent the privacy settings we have an example of more enum utilization here.
 - [For more info on private by default visit vist our help.fullstory.com.](https://help.fullstory.com/hc/en-us/articles/360044349073-FullStory-Private-by-Default#enabling-private-by-default)
*/
enum PrivacySetting: String {
    case exclude = "fs-exclude"
    case mask = "fs-mask"
    case unmask = "fs-unmask"
}

/**
 This method lets you create an FullStory event using the `Event` cases.
    - Parameter event: Event type.
    - Parameter dict: Dictionary with valuable info gathered at the time of the event.
 */
func fsCreateEvent(event: Event, with dict: [String: Any]) {
    FS.event(event.rawValue, properties: dict)
}

/**
 This method will allow you to pass a level as a parameter using dot notation with a message that will send logs to the dev tools on the FullStory app.
    - Parameter message: String to pass to the FullStory console.
    - Parameter level: LogLevel type.
 */
func fsLog(message: String, level: LogLevel = .info) {
    var fsLogType: FSEventLogLevel

    switch level {
    case .assert:
        fsLogType = FSLOG_ASSERT
    case .debug:
        fsLogType = FSLOG_DEBUG
    case .error:
        fsLogType = FSLOG_ERROR
    case .info:
        fsLogType = FSLOG_INFO
    case .warning:
        fsLogType = FSLOG_WARNING
    }

    FS.log(with: fsLogType, message: "\(Date())" + message)
}

/**
 This method allows you to modify the privacy setting on a specific view.
    - Parameter setting: `PrivacySetting`.
    - Parameter views: UIView(s) you wish to modify the privacy setting on.
 */
func fsModifyPrivacy(setting: PrivacySetting, views: UIView?...) {
    views.forEach { view in
        if let view = view {
            FS.addClass(view, className: setting.rawValue)
        }
    }
}

/**
 Here we can create an easily accessible method for FS identify.
    - Parameter id: Unique identifier for your user.
    - Parameter userInfo: Dictionary with any "relavent info" related to the user.
 */
func fsIdentify(id: String, userInfo: [String: Any]) {
    FS.identify(id, userVars: userInfo)
}

/**
Generate a unique alphanumeric ID with specified len
    - Parameter len: Desired length of ID string
*/
func makeId(len: Int) -> String {
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var randomString = ""
    for _ in 0 ..< len {
        let randomCharacter = characters.randomElement()!
        randomString.append(randomCharacter)
    }

    return randomString
}

// ------------------------
// below are functions for demostrating conversions: revenue attribution events
// ------------------------
func fsAddOrRemoveProductEvent(event: Event, with product: Product?) {
    guard let product = product else {
        return
    }
    // TODO: check for event type
    let productDict: [String : Any] = [
        "description_str": product.description,
        "displayName_str": product.title,
        "id_str": product.title,
        "imgName_str": product.imageName,
        "price_raw_real": product.price,
        "price_real": product.price,
        "product_id_str": makeId(len: 9),
        "unit_str": product.unit
    ]

    fsCreateEvent(event: event, with: productDict)
}

func fsCheckoutSuccessEvent(event: Event, with order: Order) {
    // TODO: check for event type
    fsCreateEvent(event: event, with: order.orderSummary())
}

struct CheckoutError: Error {
    let errorCode: String
    let message: String
    let order: Order
}

func fsCheckoutErrorEvent(event: Event, with error: CheckoutError) {
    let errDict: [String : Any] = [
        "code_str": error.errorCode,
        "message_str": error.message,
        "order.items_int": error.order.items.count,
        "order.order_id": error.order.orderId,
        "order.total_real": error.order.cartOrderTotal
    ]

    fsCreateEvent(event: event, with: errDict)
}
