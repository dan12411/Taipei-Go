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
    var imageURLs: [String] = []
    var imageViews: [UIImageView] = []
    
    func bindViewModel(_ dataModel: Any) {
        guard let viewModel = dataModel as? TouristSiteViewModel else { return }
        titleLabel.text = viewModel.cellTitle
        descriptionLabel.text = viewModel.description
        
        DispatchQueue.main.async {
            let imageKey: String = "http://www.travel.taipei/d_upload_ttn/sceneadmin/"
            self.imageURLs = viewModel.imageURL.components(separatedBy: imageKey)
            let urls = self.imageURLs.lazy
                .filter { $0.contains(".jpg") || $0.contains(".JPG") }
                .flatMap { URL(string: imageKey + $0) }
            var collectionViewDataSource: [CollectionViewModel] = []
            
            urls.forEach {
                let imageView = UIImageView()
                imageView.kf.setImage(with: $0)
                self.imageViews.append(imageView)
                collectionViewDataSource.append(CollectionViewModel(data: imageView))
            }
            
            self.collectionViewHelper = CollectionViewHelper(
                collectionView: self.collectionView,
                source: collectionViewDataSource ,
                nibName: "CollectionViewCell",
                selectionAction: nil
            )
            
            if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                let width = (UIScreen.main.bounds.width - 40 - 10)/2
                let height = CGFloat(130)
                flowLayout.itemSize = CGSize(width: width, height: height)
            }
        }
        
    }
    
}

