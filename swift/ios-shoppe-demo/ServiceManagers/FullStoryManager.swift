//
//  FullStoryManager.swift
//  ios-shoppe-demo
//
//  Created  5/7/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation
import FullStory
import FirebaseCrashlytics

/**
 FullStory Manager is a singleton used to manage api calls to FullStory.

    - create events
    - identify a user masking and unmasking elements
 */
class FullStoryManager {
    static var shared = FullStoryManager()

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

    enum FSStatus: String {
        case exclude = "fs-exclude"
        case mask = "fs-mask"
        case unmask = "fs-unmask"
    }

    var currentEvent: Event = .browsing

    func createFSEvent(event: Event? = nil) {
        let fsEvent: Event = event ?? currentEvent
        var properties = [String: Any]()

        switch fsEvent {
        case .browsing:
            properties = order.orderSummary()
            log(message: fsEvent.rawValue, level: .info)
        case .crash:
            FS.event(fsEvent.rawValue, properties: properties)
            log(message: fsEvent.rawValue, level: .error)
        case .addToCart:
            properties = order.orderSummary()
        default:
            log(message: fsEvent.rawValue, level: .info)
        }

        FS.event(fsEvent.rawValue, properties: properties)
    }

    func log(message: String, level: LogLevel = .info) {
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

    func fsModify(status: FSStatus, of view: UIView) {
        FS.addClass(view, className: status.rawValue)
    }
}
