//
//  TBCDashboard.swift
//  bukadana
//
//  Created by Gaenael on 1/21/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import SideMenuSwift

class TBCDashboard: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addTabbar()
        
        MOList.shared?.load()
        MOList.shared?.loadFromApi()
    }
    
    func addTabbar(){
        self.tabBar.isHidden = true
        SideMenuController.preferences.basic.menuWidth = 240
        
        let tab = UITabBar(frame: CGRect(x: 0, y: BKDNFrame.getHeight()-50, width: BKDNFrame.getWidht(), height: 50))
        tab.tag = 2
        tab.delegate = self
        
        let item1 = UITabBarItem(title: "Menu", image: UIImage(named: "ict_menu"), tag: 0)
        let item2 = UITabBarItem(title: "Dashboard", image: UIImage(named: "ict_dashboard"), tag: 1)
        let item3 = UITabBarItem(title: "Transaksi", image: UIImage(named: "ict_transaction"), tag: 2)
        let item4 = UITabBarItem(title: "Top Up", image: UIImage(named: "ict_top_up"), tag: 3)
        let item5 = UITabBarItem(title: "Tarik Tunai", image: UIImage(named: "ict_tariktunai"), tag: 4)
        
        tab.items = [item1, item2, item3, item4, item5]
        tab.selectedItem = item2
        tab.tintColor = BKDNColor.get(hex: .blue)
        if #available(iOS 10.0, *) {
            tab.unselectedItemTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        } else {
            // Fallback on earlier versions
        }
        self.selectedIndex = 1
        self.view.addSubview(tab)
    }

    //MARK: Delegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch tabBar.tag {
        case 2:
            switch item.tag{
                case 0:
                    sideMenuController?.revealMenu()
                default:
                    self.selectedIndex = item.tag
            }
        default:
            break
        }
    }
}
