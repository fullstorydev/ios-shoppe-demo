//
//  CrashlyticsManager.swift
//  ios-shoppe-demo
//
//  Created on 8/3/20.
//  Copyright © 2020 FullStory All rights reserved.
//


import Foundation
import FullStory
import FirebaseCrashlytics

func crashlyticsIdentifyAndAddUserURLs(userID: String) {
    let userVars = ["displayName": userID,
                    "crashlyticsURLAndroidDemoapp": "https://console.firebase.google.com/project/fs-crashlytics/crashlytics/app/ios:com.FullStory.ios-shoppe-demo/search?time=last-seven-days&type=crash&q="+userID]
    
    // identify User in FS and in Crashlytics
    FS.identify(userID, userVars: userVars)
    Crashlytics.crashlytics().setUserID(userID)
    
    // add FS links to the crash report as custom key
    guard let plist = getPlist(withName: "Info") else { return }
    guard let org = plist["FSOrgId"] else { return }
    let fsUserUrl = "https://app.staging.fullstory.com/ui/" + org + "/segments/everyone/people:search:(:((UserAppKey:==:%22" + userID + "%22)):():():():)/0)";
   
    Crashlytics.crashlytics().setCustomValue("FSUserSearchURL", forKey: fsUserUrl);
}

func crashlyticsHandleNonFatalException(e: Error) {
    Crashlytics.crashlytics().record(error: e)

    // Send the error to FS
    let eventVars = ["errorMessage": e.localizedDescription]
    FS.event("nonFatalException",properties: eventVars)
    FS.log(with: FSLOG_ERROR, message: e.localizedDescription)
}

func crashlyticsLog(logMsg: String) {
    Crashlytics.crashlytics().log(logMsg)
    FS.log(with: FSLOG_INFO, message: logMsg)
}
