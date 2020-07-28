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
    case addToCart
    case browsing
    case checkout
    case crash
    case itemSelected
    case removeFromCart
    case viewCart
}

enum LogLevel {
    case assert, debug, error, info, warning
}

/**
 For the hardcoded values that represent the privacy settings we have an example of more enum utilization here.
 - For more info on how to use a  https://help.fullstory.com/hc/en-us/articles/360044349073-FullStory-Private-by-Default#exclude-fs-exclude
*/
enum PrivacySetting: String {
    case exclude = "fs-exclude"
    case mask = "fs-mask"
    case unmask = "fs-unmask"
}

/**
 This is a convenience method that takes a case and a dictionary to title the event and provide properties.
    - Parameter event: This is an Event type.
    - Parameter dict: This should be a dictionary containing valuable info gathered at the time of the event.
 */
func fsCreateEvent(event: Event, with dict: [String: Any]) {
    FS.event(event.rawValue, properties: dict)
}

/**
 This method will allow you to pass a level as a parameter using dot notation with a message that will send logs to the dev tools on the FullStory app.
    - Parameter message: A text string that will be logged to the FullStory console.
    - Parameter level: This a LogLevel type.
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
    - Parameter setting: This is a PrivacySetting.
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
