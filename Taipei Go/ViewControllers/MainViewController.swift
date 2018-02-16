//
//  ViewController.swift
//  Taipei Go
//
//  Created by 洪德晟 on 30/01/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit
import PKHUD

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var touristSiteViewModel = TouristSiteViewModel(page: 0)
    fileprivate var tableViewDataSource: [TouristSiteViewModel] = []
    fileprivate var tableHelper: TableViewHelper?
    
    fileprivate func addNotification() {
        Notifier.NetworkConnection.addObserver(by: self, with: #selector(networkConnection), object: nil)
        Notifier.NetworkDisconnection.addObserver(by: self, with: #selector(networkDisconnection), object: nil)
    }
    
    fileprivate func removeNotification() {
        Notifier.NetworkConnection.remove(from: self)
        Notifier.NetworkDisconnection.remove(from: self)
    }

    fileprivate func checkNetworkStatus() {
        if NetworkChecker.shared.isReachable {
            networkConnection()
        } else {
            networkDisconnection()
        }
    }
    
    @objc func networkConnection() {
        HUD.show(.progress)
        self.touristSiteViewModel.fetchData { [unowned self] data in
            self.tableViewDataSource = data.map { TouristSiteViewModel(data: $0) }

            self.tableHelper = TableViewHelper(
                tableView: self.tableView,
                nibName: "TouristSiteTableViewCell",
                source: self.tableViewDataSource as [AnyObject],
                loadMoreAction: {
                    self.touristSiteViewModel.page += 1
                    HUD.show(.progress)
                    self.touristSiteViewModel.fetchData { [unowned self] data in
                        let newData = data.map { TouristSiteViewModel(data: $0) }
                        self.tableViewDataSource.append(contentsOf: newData)
                        self.tableHelper?.reloadData = self.tableViewDataSource
                        HUD.hide()
                    }
            })
            self.tableView.reloadData()
            HUD.hide()
        }
    }
    
    @objc func networkDisconnection() {
        NetworkChecker.shared.showAlert(from: self)
    }
    
    fileprivate func setupUI() {
        self.title = touristSiteViewModel.title
        let backButton = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addNotification()
        checkNetworkStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail") {
            if let detailVC = segue.destination as? DetailViewController,
                let indexString = sender as? String,
                let index = Int(indexString)
            {
                detailVC.dataSource = tableViewDataSource[index-1]
            }
        }
    }
    
    deinit{
        removeNotification()
    }

}

