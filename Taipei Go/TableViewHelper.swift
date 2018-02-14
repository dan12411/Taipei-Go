//
//  TableViewHelper.swift
//  Taipei Go
//
//  Created by 洪德晟 on 01/02/2018.
//  Copyright © 2018 Dan. All rights reserved.
//

import UIKit

protocol BindView {
    func bindViewModel(_ dataModel: Any)
}

class TableViewHelper: NSObject {
    
    fileprivate let tableView: UITableView
    let templateCell: UITableViewCell
    let dataSource: DataSource
    var savedData: [AnyObject] = [] {
        
        didSet{
            //this for refresh(load more)data
            dataSource.data = savedData
            dataSource.flag = true
            tableView.reloadData()
        }
    }
    var headSavedData: [AnyObject] = [] {
        didSet{
            //this for refresh(load more)data
            dataSource.headerData = headSavedData
            dataSource.sectionCount = headSavedData.count
        }
    }
    
    var reloadData: [AnyObject] = []{
        didSet{
            dataSource.data = reloadData
            tableView.reloadData()
        }
    }
    
    init(
        tableView:      UITableView,
        nibName:        String,
        source:         [AnyObject],
        sectionCount:   Int = 1,
        sectionNib:     String? = nil,
        sectionSource:  [AnyObject]? = nil,
        selectAction:   ((Int)->())? = nil,
        refreshAction:  ((Int)->())? = nil,
        loadMoreAction: (()->())? = nil
        )
    {
        self.tableView = tableView
        
        let nib = UINib(nibName: nibName, bundle: nil)
        
        // create an instance of the template cell and register with the table view
        templateCell = nib.instantiate(withOwner: nil, options: nil)[0] as! UITableViewCell
        tableView.register(nib, forCellReuseIdentifier: templateCell.reuseIdentifier!)
        
        dataSource = DataSource(data: [], templateCell: templateCell, selectAction: nil)
        
        super.init()
        
        //set datasource variables
        dataSource.data = source
        dataSource.selectAction = selectAction
        dataSource.refreshAction = refreshAction
        dataSource.loadMoreAction = loadMoreAction
        dataSource.flag = true
        dataSource.sectionCount = sectionCount
        
        if sectionNib != nil{
            dataSource.templateHeader = UINib(nibName: sectionNib!, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UITableViewHeaderFooterView
            dataSource.headerData = sectionSource
            tableView.register(UINib(nibName: sectionNib!, bundle: nil), forHeaderFooterViewReuseIdentifier: sectionNib!)
            dataSource.sectionNibIsExisted = true
        }
        
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
        self.tableView.reloadData()
    }
}

class DataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate let templateCell: UITableViewCell
    var templateHeader: UITableViewHeaderFooterView?
    var sectionNibIsExisted: Bool = false
    var flag:           Bool = true
    var sectionCount:   Int = 1
    var data:           [AnyObject]
    var headerData:     [AnyObject]?
    var selectAction:   ((Int)->())?
    var refreshAction:  ((Int)->())?
    var loadMoreAction: (()->())?
    
    init(data: [AnyObject], templateCell: UITableViewCell, selectAction: ((Int)->())? = nil) {
        self.data = data
        self.templateCell   = templateCell
        self.selectAction   = selectAction
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionCount > 1{
            //if more than 1 section
            return data[section].count
        }else{
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: templateCell.reuseIdentifier!)!
        if let reactiveView = cell as? BindView {
            if self.sectionCount > 1{
                //if more than 1 section
                if let datas = data[indexPath.section] as? [AnyObject], !datas.isEmpty{
                    reactiveView.bindViewModel(datas[indexPath.row])
                }
            }else{
                reactiveView.bindViewModel(data[indexPath.row])
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectAction?(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.sectionNibIsExisted{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: (templateHeader?.reuseIdentifier)!)
            if let reactiveView = headerView as? BindView{
                reactiveView.bindViewModel(headerData![section])
            }
            return headerView
        }else{
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            // return your header height
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    var page = 1
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //if tableview can refresh(load more) data
        if let refreshAction = self.refreshAction{
            let offset = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            if (contentHeight - scrollView.frame.size.height) - offset < 44 && flag{
                page += 1
                refreshAction(page)
                flag = false
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 {
            guard let action = loadMoreAction else { return }
            action()
        }
    }
    
}
