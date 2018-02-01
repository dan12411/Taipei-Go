//
//  Notifier.swift
//  Taipei Go
//
//  Created by 洪德晟 on 01/02/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import Foundation

enum Notifier: Notifiable {
    
    case NetworkConnection
    case NetworkDisconnection
    
    var name: Notification.Name {
        
        switch self {
        case .NetworkConnection:
            return .init(rawValue: "NetworkConnection")
        case .NetworkDisconnection:
            return .init(rawValue: "NetworkDisconnection")
        }
    }
}

protocol Notifiable {
    
    var name: Notification.Name { get }
    
    func addObserver<T: AnyObject>(by observer: T, with selector: Selector, object: Any?)
    func post(object: Any?, userInfo: [AnyHashable: Any]?)
    func remove<T: AnyObject>(from observer: T)
    
    func addObserver(object: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Swift.Void)
}

extension Notifiable {
    
    func addObserver<T: AnyObject>(by observer: T, with selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    
    func post(object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
    
    func remove<T: AnyObject>(from observer: T) {
        NotificationCenter.default.removeObserver(observer, name: name, object: nil)
    }
    
    func addObserver(object: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Swift.Void) {
        NotificationCenter.default.addObserver(forName: name, object: object, queue: queue, using: block)
    }
}
