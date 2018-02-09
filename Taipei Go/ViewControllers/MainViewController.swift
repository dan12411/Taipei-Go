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
    
    fileprivate lazy var touristSiteViewModel = TouristSiteViewModel(page: 0)
    fileprivate var tableViewDataSource: [TouristSiteViewModel] = []
    fileprivate var tableHelper: TableViewHelper?
    
    @objc func selectionAction() {
        let detailViewController = DetailViewController.instance()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
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
        self.touristSiteViewModel.fetchData { [unowned self] data in
            self.tableViewDataSource = data.map { TouristSiteViewModel(data: $0) }
            self.tableHelper = TableViewHelper(
                tableView: self.tableView,
                nibName: "TouristSiteTableViewCell",
                source: self.tableViewDataSource as [AnyObject],
                loadMoreAction: {
                    self.touristSiteViewModel.page += 1
                    
                    self.touristSiteViewModel.fetchData { [unowned self] data in
                        let newData = data.map { TouristSiteViewModel(data: $0) }
                        self.tableViewDataSource.append(contentsOf: newData)
                        self.tableHelper?.reloadData = self.tableViewDataSource
                    }
            })
            self.tableView.reloadData()
        }
    }
    
    @objc func networkDisconnection() {
        NetworkChecker.shared.showAlert(from: self)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = touristSiteViewModel.title
        addNotification()
        checkNetworkStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    deinit{
        removeNotification()
    }

}

