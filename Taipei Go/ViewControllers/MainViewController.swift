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
        self.viewModel.fetchData { [unowned self] data in
            self.viewModel.dataSource = data
            self.tableView.reloadData()
        }
    }
    
    @objc func networkDisconnection() {
        NetworkChecker.shared.showAlert(from: self)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.title
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

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension MainViewController: UITableViewDelegate {
    
}

