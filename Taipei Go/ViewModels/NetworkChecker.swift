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
    
    func setupReachability(viewController: UIViewController, reachableAction: (() -> Void)? = nil) {
        
        reachability?.listener = { status in
            switch status {
            case .reachable(_), .unknown:
                guard let action = reachableAction else { return }
                DispatchQueue.main.async {
                    action()
                }
            case .notReachable:
                self.showAlert(from: viewController)
            }
        }
        
        reachability?.startListening()
    }
    
    func showAlert(from viewController: UIViewController) {
        let alert = UIAlertController(title: "Error", message: "Network Disconnection", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
