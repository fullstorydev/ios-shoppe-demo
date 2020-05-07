//
//  FullStoryManager.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 5/7/20.
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
    static var sharedInstance = FullStoryManager()

    enum Event: String {
        case browsing
        case itemSelected
        case viewCart
        case addToCart
        case removeFromCart
        case crash
    }

    var currentEvent: Event = .browsing

    func creatFSEvent() {
        var properties = [String: Any]()

        switch currentEvent {
        case .crash:

            FS.event(currentEvent.rawValue, properties: properties)
        default:
            break
        }
    }
}
