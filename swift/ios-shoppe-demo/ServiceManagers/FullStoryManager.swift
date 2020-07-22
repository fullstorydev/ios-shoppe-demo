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
 FullStory Manager is a file full of functions and enums that can make the FullStory API easier to apply to areas of your project.
    - Identifying a user
    - create events
    - logging
    - masking, unmasking, and excluding elements
 */

/// We created an enum that represents the major events in the iOS app. (This could be different for you based on the flow of your app.)
enum Event: String {
    case browsing
    case itemSelected
    case viewCart
    case addToCart
    case checkout
    case removeFromCart
    case crash
}

enum LogLevel {
    case assert, error, warning, info, debug
}

/// For the hardcoded values that represent the privacy settings we have an example of more enum utilization here.
enum PrivacySetting: String {
    case exclude = "fs-exclude"
    case mask = "fs-mask"
    case unmask = "fs-unmask"
}

/**
 This is a convenience method that takes a case and a dictionary to title the event and provide properties.
    - Parameter event: `browsing`, `itemSelected`, `viewCart`, `addToCart`, `checkout`, `removeFromCart`, and `crash` (This could be different for you based on the flow of your app.).
    - Parameter dictionary: This should be a dictionary containing valuable info gathered at the time of the event.
 */
func fsCreateEvent(event: Event, with dict: [String: Any]) {
    FS.event(event.rawValue, properties: dict)
}

/**
  This method will allow you to pass a level as a parameter using dot notation with a message that will send logs to the dev tools on the FullStory app.

    - Parameter message: A text string that will be logged to the FullStory console.
    - Parameter level: 'assert', 'info', 'warning', 'error', and 'debug'. (This is optional and will be set as info by defualt)
 */
func fsLog(message: String, level: LogLevel = .info) {
    var fsLogType: FSEventLogLevel

    switch level {
    case .assert:
        fsLogType = FSLOG_ASSERT
    case .error:
        fsLogType = FSLOG_ERROR
    case .warning:
        fsLogType = FSLOG_WARNING
    case .info:
        fsLogType = FSLOG_INFO
    case .debug:
        fsLogType = FSLOG_DEBUG
    }

    FS.log(with: fsLogType, message: "\(Date())" + message)
}

/**
 This method allows you to modify the privacy setting on a specific view.
    - Parameter setting: `exclude`, `mask`, and `unmask`.
    - Parameter views: a UIView you wish to modify the privacy setting on.
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

 - Parameter id: A unique identifier for your user.
 - Parameter userInfo: This should be a dictionary containing any "import" you want to capture about your user.
 */
func fsIdentify(id: String, userInfo: [String: Any]) {
    FS.identify(id, userVars: userInfo)
}
