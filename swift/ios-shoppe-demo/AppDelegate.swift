//
//  AppDelegate.swift
//  ios-shoppe-demo
//
//  Created on 3/3/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import UIKit
import FullStory
import Analytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, FSDelegate {

    func fullstoryDidStartSession(_ sessionUrl: String) {
    }

    func fullstoryDidStopSession() {

    }

    func fullstoryDidTerminateWithError(_ error: Error) {

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FS.delegate = self
        
        let configuration = SEGAnalyticsConfiguration.init(writeKey: "w44t5luR7FK0fK9w3YG4FcB1G2NLYoZa");
        configuration.trackApplicationLifecycleEvents = true; // Enable this to record certain application events automatically!
//        configuration.flushAt = 1;
        
        let fsm: FullStoryMiddleware = FullStoryMiddleware.init(whitelistEvents: ["Cart view did load"])
        fsm.sendScreen(asEvents: true)
        fsm.enableFSSessionURL(inEvent: true);
        fsm.enableGroupTraits(toUserVars: true)
        


        configuration.middlewares = [
            fsm
        ]
        SEGAnalytics.setup(with: configuration)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

