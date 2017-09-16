//
//  NSNotificationCenter+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import Foundation


public func postNotificaion(_ notification: String, userInfo: [AnyHashable: Any]? = nil) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification), object: nil, userInfo: userInfo)
}

public func subscribeToNotification(_ notification: String, observer: AnyObject, selector: Selector) {
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: notification), object: nil)
}

public typealias RemoveNotificationObserver = () -> ()
public func subscribeToNotification(_ notification: String, block: @escaping (Foundation.Notification) -> Void) -> RemoveNotificationObserver {
    let observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notification), object: nil, queue: nil, using: block)
    
    return {
        NotificationCenter.default.removeObserver(observer)
    }
}
