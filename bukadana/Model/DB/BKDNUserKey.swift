//
//  BKDNUserKeyModel.swift
//  bukadana
//
//  Created by Gaenael on 1/30/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import RealmSwift

enum typeUser: String{
    case peminjam = "1"
    case pendana  = "2"
}

class BKDNUserKey:  Object {
    @objc dynamic var token: String? = ""
    @objc dynamic var type:  String? = ""
}

class BUserKeyModel{
    static func save(token: String?, type: String?){
        self.clear()
        let model   = BKDNUserKey()
        model.token = token
        model.type  = type
        self.add(userKey: model)
    }
    
    static func getType() -> String{
        let realm = try! Realm()
        let user = realm.objects(BKDNUserKey.self)[0]
        return user.type ?? "1"
    }
    
    static func getToken() -> String{
        let realm = try! Realm()
        let user = realm.objects(BKDNUserKey.self)[0]
        return user.token ?? ""
    }
    
    static func checkUser() -> Bool{
        let realm = try! Realm()
        let user = realm.objects(BKDNUserKey.self)
        if user.count > 0{
            return true
        }
        else{
            return false
        }
    }
    
    static func logout(){
        self.clear()
    }
}

extension BUserKeyModel{
    private static func add(userKey: BKDNUserKey){
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(userKey)
        }
    }
    
    private static func clear(){
        let realm = try! Realm()
        let tempread = realm.objects(BKDNUserKey.self)
        
        try! realm.write {
            realm.delete(tempread)
        }
    }
}
