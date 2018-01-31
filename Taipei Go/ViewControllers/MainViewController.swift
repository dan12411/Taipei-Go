//
//  ViewController.swift
//  Taipei Go
//
//  Created by 洪德晟 on 30/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var viewModel: DataTaipeiViewModel = DataTaipeiViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        NetworkChecker.shared.setupReachability(viewController: self, reachableAction: {
            self.viewModel.fetchData()
        })
        
    }

}

