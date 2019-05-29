//
//  MOList.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class MOList: NSObject {
    
    static var shared : MOList? = MOList()
    
    var province : [[String:String]] = [[String:String]]()
    var bank     : [[String:String]] = [[String:String]]()
    var mikro    : MMikro            = MMikro()
    var kilat    : MKilat            = MKilat()
    
    class func destroy() {
        self.shared = nil
    }
    
    private override init() {
        print("init singleton")
    }
    
    deinit {
        print("deinit singleton")
    }
    
    func load(){
        self.province = BKDNDataArray.getListProvinsi()
        self.bank     = BKDNDataArray.getBank()
    }
    
    func loadFromApi(){
        let apiBank = APILBank()
        apiBank.getData { (st, err) in
            
        }
        
        let apiProvinsi = APILProvinsi()
        apiProvinsi.getData { (st, err) in
            
        }
        
        kilat.loadByApi()
        mikro.loadByApi()
    }
}
