//
//  BKDNController.swift
//  bukadana
//
//  Created by Gaenael on 2/9/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BKDNController: NSObject {
    static func getAppDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    static func changeRoot(vc: UIViewController){
        let appDelegate = self.getAppDelegate()
        appDelegate.window?.rootViewController = vc
    }
    
    static func getControllerFrom(storyoard:String, identifier:String) -> UIViewController{
        let storyboard = UIStoryboard(name: storyoard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        
        return controller
    }
}
