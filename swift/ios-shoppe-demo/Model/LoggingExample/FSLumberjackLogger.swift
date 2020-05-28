//
//  FSLumberjackLogger.swift
//  ios-shoppe-demo
//
//  Created by Harold Davis Jr. on 5/27/20.
//  Copyright © 2020 Harold Davis Jr. All rights reserved.
//

import Foundation
import FullStory
import CocoaLumberjack

class FSLumberjackLogger : DDAbstractLogger {

    override var loggerName: DDLoggerName {
        return DDLoggerName("com.fullstory.logger")
    }

    func logMessage(logMessage: DDLogMessage) {
        var logMsg: String = logMessage.message

        if ((self.logFormatter) != nil) {
            logMsg =  "\(self.logFormatter?.format(message: logMessage) ?? "Could not parse logFormatter")"

            var logLevel: FSEventLogLevel = FSLOG_DEBUG;

            switch (logMessage.flag) {
            case .error:
                    logLevel = FSLOG_ERROR;
            case .warning:
                    logLevel = FSLOG_WARNING;
            case .info:
                    logLevel = FSLOG_INFO;
            case .debug:
                logLevel = FSLOG_DEBUG
                default:
                    logLevel = FSLOG_INFO;
            }

            FS.log(with: logLevel, message: logMsg)
        }
    }





}
