//
//  ViewController.swift
//  Taipei Go
//
//  Created by 洪德晟 on 30/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: DataTaipeiViewModel = DataTaipeiViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        NetworkChecker.shared.setupReachability(viewController: self, reachableAction: {
            self.viewModel.fetchData()
        })
        
    }

}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension MainViewController: UITableViewDelegate {
    
}

