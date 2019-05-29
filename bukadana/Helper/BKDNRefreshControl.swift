//
//  BKDNRefreshControl.swift
//  bukadana
//
//  Created by Gaenael on 2/17/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol BKDNRefreshControlDelegate {
    func actionRefresh()
}
class BKDNRefreshControl: NSObject {
    
    var delegate: BKDNRefreshControlDelegate?
    var refreshControl = UIRefreshControl()
    
    func addRefresh(tableView: UITableView){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    func setTitle(title: String){
        refreshControl.attributedTitle = NSAttributedString(string: title)
    }
    
    func stopAnimation(){
        refreshControl.endRefreshing()
    }
    
    @objc func refresh(_ sender: Any) {
        //  your code to refresh tableView
        delegate?.actionRefresh()
    }
}

