//
//  TouristSiteTableViewCell.swift
//  Taipei Go
//
//  Created by 洪德晟 on 01/02/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

class TouristSiteTableViewCell: UITableViewCell, BindView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func bindViewModel(_ dataModel: Any) {
        guard let viewModel = dataModel as? TouristSiteViewModel else { return }
        titleLabel.text = viewModel.cellTitle
        descriptionLabel.text = viewModel.description
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
