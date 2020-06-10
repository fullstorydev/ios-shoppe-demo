//
//  FullStoryManager.swift
//  ios-shoppe-demo
//
//  Created 5/7/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import FullStory
import FirebaseAnalytics

/**
 FullStory Manager is a file full of functions and enums that can make the FullStory API easier to apply to areas of your project.
    - create events
    - logging and unmasking elements
 */

enum Event: String {
    case browsing
    case itemSelected
    case viewCart
    case addToCart
    case checkout
    case removeFromCart
    case crash
}

enum LogLevel: String {
    case assert, error, warning, info, debug
}

enum PrivacySetting: String {
    case exclude = "fs-exclude"
    case mask = "fs-mask"
    case unmask = "fs-unmask"
}


func fsCreateEvent(event: Event, with dict: [String: Any]) {
    print("Session:" + Analytics.appInstanceID())
    FS.event(event.rawValue, properties: dict)
    Analytics.logEvent(event.rawValue , parameters: ["Session": FS.currentSessionURL ?? "No FullStory session available"])
}

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

func fsModifyPrivacy(setting: PrivacySetting, of view: UIView) {
    FS.addClass(view, className: setting.rawValue)
}

func fsIdentify(sessionURL: String) {
    let userID: String = "0232432342"
    fsLog(message: "Captured user info.")
    Analytics.logEvent("Started Capture Session", parameters: ["FullStorrySessionURL": sessionURL])
    Analytics.setUserProperty("Harold", forName: "username")
    
    FS.identify(userID, userVars: ["username": "Harold","email":"harold_davis@icloud.com"])
}
