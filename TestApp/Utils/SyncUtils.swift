//
//  SyncUtils.swift
//  TestApp
//
//  Created by Georges Jamous on X/X/X.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import Foundation

final class SyncUtils {
    
    // Synchronized prevents the lock from being modified by another thread
    static func Synchronize(lock: AnyObject, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }

}

