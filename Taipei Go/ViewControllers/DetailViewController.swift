//
//  DetailViewController.swift
//  Taipei Go
//
//  Created by 洪德晟 on 30/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor(netHex: 0x666666)
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = UIColor(netHex: 0x666666)
        }
    }
    
    var dataSource: TouristSiteViewModel?
    var imageViews: [UIImageView] = []

    fileprivate func setupUI() {
        self.navigationController?.view.tintColor = .white
        
        if let data = dataSource {
            self.title = data.cellTitle
            titleLabel.text = data.cellTitle
            descriptionLabel.text = data.description
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 240
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 300
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailImages") {
            if let imagesVC = segue.destination as? DetailImagePageViewController,
                let data = dataSource {
                imagesVC.imageViews = data.imageViews
            }
        }
    }

}
