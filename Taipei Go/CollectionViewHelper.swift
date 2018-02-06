//
//  CollectionViewHelper.swift
//  Taipei Go
//
//  Created by 洪德晟 on 06/02/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

class CollectionViewHelper: NSObject {
    
    //MARK: - Properties
    fileprivate let collectionView: UICollectionView
    fileprivate let templateCell: UICollectionViewCell
    fileprivate let dataSource: CollectionViewDataSource
    
    var reloadData: [AnyObject] = []{
        didSet{
            dataSource.data = reloadData
            collectionView.reloadData()
        }
    }
    
    //MARK: - Public API
    
    init(collectionView: UICollectionView, source: [AnyObject] , nibName: String, selectionAction: ((Int)->())? = nil) {
        self.collectionView = collectionView
        
        let nib = UINib(nibName: nibName, bundle: nil)
        
        // create an instance of the template cell and register with the table view
        templateCell = nib.instantiate(withOwner: nil, options: nil)[0] as! UICollectionViewCell
        collectionView.register(nib, forCellWithReuseIdentifier: templateCell.reuseIdentifier!)
        
        dataSource = CollectionViewDataSource(data: [], templateCell: templateCell, selectionAction: selectionAction)
        
        super.init()
        
        //set datasource variables
        dataSource.data = source
        dataSource.selectionAction = selectionAction
        
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = dataSource
        self.collectionView.reloadData()
        
    }
}

class CollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    fileprivate let templateCell: UICollectionViewCell
    fileprivate var selectionAction: ((Int)->())?
    var data: [AnyObject]
    
    
    init(data: [AnyObject], templateCell: UICollectionViewCell, selectionAction: ((Int)->())? = nil) {
        self.data = data
        self.templateCell = templateCell
        self.selectionAction = selectionAction
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = data[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: templateCell.reuseIdentifier!, for: indexPath)
        if let reactiveView = cell as? BindView {
            reactiveView.bindViewModel(item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectionAction!(indexPath.row)
    }
}
