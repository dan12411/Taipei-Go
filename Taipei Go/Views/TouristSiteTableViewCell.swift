//
//  TouristSiteTableViewCell.swift
//  Taipei Go
//
//  Created by 洪德晟 on 01/02/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit
import Kingfisher

class TouristSiteTableViewCell: UITableViewCell, BindView {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor(netHex: 0x666666)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = UIColor(netHex: 0x686868)
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var collectionViewHelper: CollectionViewHelper?
    var rowNumber: String = ""
    
    func bindViewModel(_ dataModel: Any) {
        guard let viewModel = dataModel as? TouristSiteViewModel else { return }
        self.titleLabel.text = viewModel.cellTitle
        self.descriptionLabel.text = viewModel.description
        self.rowNumber = viewModel.rowNumber
        
        var collectionViewDataSource: [CollectionViewModel] = []
        
        viewModel.imageViews.forEach {
            collectionViewDataSource.append(CollectionViewModel(imageView: $0))
        }
        
        DispatchQueue.main.async {
            self.collectionViewHelper = CollectionViewHelper(
                collectionView: self.collectionView,
                source: collectionViewDataSource ,
                nibName: "CollectionViewCell",
                selectionAction: { [unowned self] index in
                    
                  let vc = UIApplication.topViewController()
                   vc?.performSegue(withIdentifier: "toDetail", sender: self.rowNumber)
            })
            
            if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                let width = (UIScreen.main.bounds.width - 40 - 10)/2
                let height = CGFloat(130)
                flowLayout.itemSize = CGSize(width: width, height: height)
            }
        }
        
    }
    
}

