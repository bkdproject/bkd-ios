//
//  BKDNLog.swift
//  bukadana
//
//  Created by Gaenael on 1/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BKDNLog: NSObject {
    enum type:String {
        case url   = "URL  ",
        param      = "PARAM",
        json       = "JSON ",
        err        = "ERROR",
        varia      = "VARIABLE",
        other      = "OTHER"
    }
    private static let separator = " .:. "
    
    static func log(str:String, types: type){
        if !BKDNConfig.is_production{
            handleLog(str: str, types: types)
        }
    }
    
    private static func handleLog(str:String, types: type){
        let tp = types.rawValue
        print(tp + separator + str)
    }
}
