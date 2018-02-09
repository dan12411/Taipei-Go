//
//  UIViewController+Addition.swift
//  Cafe Go
//
//  Created by 洪德晟 on 16/10/2017.
//  Copyright © 2017 洪德晟. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func instance() -> Self {
        let storyboardName = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.initialViewController()
    }
}
