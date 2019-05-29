//
//  BKDNAlert.swift
//  bukadana
//
//  Created by Gaenael on 1/31/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BKDNAlert: NSObject {
    
    static func showAlertErr(title: String, msg:String) -> UIAlertController{
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(addAlertAction(title: "Close", style: .cancel))
        return alert
    }
    
    static func showAlertSuccess(title: String, msg:String, action:@escaping ((UIAlertAction)->())) -> UIAlertController{
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(addAlertAction(title: "Done", style: .default, action: action))
        return alert
    }
    
    static func showAlertYesNo(title: String, msg:String, actionYes:@escaping ((UIAlertAction)->()), actionNo:@escaping ((UIAlertAction)->())) -> UIAlertController{
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(addAlertAction(title: "Yes", style: .default, action: actionYes))
        alert.addAction(addAlertAction(title: "No", style: .default, action: actionNo))
        return alert
    }
    
    static func showAlertLogout(action:@escaping ((UIAlertAction)->())) -> UIAlertController{
        let alert = UIAlertController.init(title: "Logout", message: "Are you sure want to logout", preferredStyle: .actionSheet)
        alert.addAction(addAlertAction(title: "Yes", style: .default, action: action))
        alert.addAction(addAlertAction(title: "Cancel", style: .cancel, action: nil))
        return alert
    }
    
    static func showAlertChangeImage(action:@escaping ((UIAlertAction)->()), action2:@escaping ((UIAlertAction)->())) -> UIAlertController{
        let alert = UIAlertController.init(title: "Image", message: "", preferredStyle: .actionSheet)
        alert.addAction(addAlertAction(title: "Change Image", style: .default, action: action))
        alert.addAction(addAlertAction(title: "Remove", style: .default, action: action2))
        alert.addAction(addAlertAction(title: "Cancel", style: .cancel, action: nil))
        return alert
    }
    
    static private func addAlertAction(title:String, style: UIAlertAction.Style, action:((UIAlertAction)->())? = nil) -> UIAlertAction{
        let action = UIAlertAction.init(title: title, style: style, handler: action)
        return action
    }
}
