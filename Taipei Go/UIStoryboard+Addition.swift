//
//  UIStoryboard+Extensions.swift
//  BESV SPORT APP
//
//  Created by 洪德晟 on 2017/4/13.
//  Copyright © 2017年 洪德晟. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func initialViewController<T: UIViewController>() -> T {
        return self.instantiateInitialViewController() as! T
    }
    
}
