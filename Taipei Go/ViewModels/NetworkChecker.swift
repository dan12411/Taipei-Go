//
//  NetworkChecker.swift
//  Taipei Go
//
//  Created by 洪德晟 on 31/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit
import Alamofire

final class NetworkChecker {
    
    static let shared = NetworkChecker()
    private init() {}
    
    let reachability = NetworkReachabilityManager()
    
    var isReachable: Bool {
        guard let status = reachability?.isReachable else { return false }
        return status
    }
    
    func startMonitoring() {
        
        reachability?.listener = { status in
            switch status {
            case .reachable(_), .unknown:
                Notifier.NetworkConnection.post(object: nil, userInfo: nil)
            case .notReachable:
                Notifier.NetworkDisconnection.post(object: nil, userInfo: nil)
            }
        }
        
        reachability?.startListening()
    }
    
    func stopMonitoring() {
        reachability?.stopListening()
    }
    
    func showAlert(from viewController: UIViewController) {
        let alert = UIAlertController(title: "Error", message: "Network Disconnection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
