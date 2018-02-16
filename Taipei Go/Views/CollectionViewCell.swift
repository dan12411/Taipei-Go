//
//  CollectionViewCell.swift
//  Taipei Go
//
//  Created by 洪德晟 on 06/02/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, BindView {

    @IBOutlet weak var imageView: UIImageView!
    
    func bindViewModel(_ dataModel: Any) {
        guard let viewModel = dataModel as? CollectionViewModel else { return }
        self.imageView.image = viewModel.image
    }

}
