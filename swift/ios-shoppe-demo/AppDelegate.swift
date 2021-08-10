//
//  AppDelegate.swift
//  ios-shoppe-demo
//
//  Created on 3/3/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, FSDelegate {

    func fullstoryDidStartSession(_ sessionUrl: String) {
        NSLog("FS Session URL: %@", FS.currentSessionURL ?? "nil")
    }

    func fullstoryDidStopSession() {

    }

    func fullstoryDidTerminateWithError(_ error: Error) {

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FS.delegate = self

        let configuration = AnalyticsConfiguration.init(writeKey: "your_write_key")
        
        let fsm = FullStoryMiddleware.init()
        // allow all events to be tracked by FS, defualt to false
        fsm.allowlistAllTrackEvents = true
        // allow FS session URL to be added in segemnt event properties, default to true
        fsm.enableFSSessionURLInEvents = true
        // enable to send group traits as userVars, default to false
        fsm.enableGroupTraitsAsUserVars = true
        // enable to send FS custom events on screen event, default to false
        fsm.enableSendScreenAsEvents = true
        
        configuration.sourceMiddleware = [fsm]
        Analytics.setup(with: configuration)
        
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

