//
//  BKDNAPIError.swift
//  bukadana
//
//  Created by Gaenael on 1/30/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BKDNAPIError: NSObject {
    var code = ""
    var msg  = ""
    
    override init() {
        super.init()
    }
    
    func set(data:[String:Any]){
        do{
            if let code = data["code"]{
                self.code = code as! String
            }
            
            if let code = data["message"]{
                self.msg = code as! String
            }
        }
    }
}
