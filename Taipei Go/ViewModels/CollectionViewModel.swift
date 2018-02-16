
//
//  CollectionViewModel.swift
//  Taipei Go
//
//  Created by 洪德晟 on 06/02/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

class CollectionViewModel {
    
    var image: UIImage?
    
    init(imageView: UIImageView) {
        self.image = imageView.image
    }
}
