//
//  BKDNUserSaldo.swift
//  bukadana
//
//  Created by Gaenael on 2/10/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import RealmSwift

class BKDNUserSaldo: Object {
    @objc dynamic var saldo: Int = 0
}

class BKDNUserSaldoModel{
    static func save(data: Dictionary<String, Any>){
        self.clear()
        var saldo   = data["Amount"] as? String ?? "0"
        saldo       = saldo.replacingOccurrences(of: ",", with: "")
        let model   = BKDNUserSaldo()
        model.saldo = Int(saldo) ?? 0
        self.add(userKey: model)
    }
    
    static func getData() -> BKDNUserSaldo{
        let realm = try! Realm()
        let data = realm.objects(BKDNUserSaldo.self)
        if data.count > 0{
            return data[0]
        }
        else{
            return BKDNUserSaldo()
        }
    }
}

extension BKDNUserSaldoModel{
    private static func add(userKey: BKDNUserSaldo){
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(userKey)
        }
    }
    
    private static func clear(){
        let realm = try! Realm()
        let tempread = realm.objects(BKDNUserSaldo.self)
        
        try! realm.write {
            realm.delete(tempread)
        }
    }
}
