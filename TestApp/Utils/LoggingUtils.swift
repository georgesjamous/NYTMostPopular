//
//  LoggingUtils.swift
//  TestApp
//
//  Created by Georges Jamous on 3/3/19.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import Foundation

// Logger is a simple logging class

final class Logger {
    private init(){}
    
    static func Info(message:String, function:String = #function) {
        Logger.log(message: "[INFO] \(message)", function: function)
    }
    
    static func Warn(message:String, function:String = #function) {
        Logger.log(message: "[WARN] \(message)", function: function)
    }
    
    static private func log(message:String, function:String = #function) {
        print("%@, %@", function, message)
        // firebase..
        // oslog..
    }
}


