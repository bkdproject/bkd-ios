
//
//  MKilat.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class MKilat: NSObject {
    var pinjaman = [[String]]()
    var products = [[String]]()
    
    override init() {
        super.init()
        self.load()
    }
    
    func load(){
        self.pinjaman = [["4", "1000000"],
                         ["5", "2000000"],
                         ["6", "3000000"]]
        
        self.products = [["1", "7"]]
    }
    
    func loadByApi(){
        let api = APILPengajuanKilat()
        api.getData { (data, err) in
            if err == nil{
                self.setFromObject(data: data)
            }
            else{
                
            }
        }
    }
    
    func setFromObject(data: Dictionary<String,Any>){
        if let pinjaman = data["pinjaman"] as? [Dictionary<String,Any>]{
            var new = [[String]]()
            
            for d in pinjaman{
                let id = d["id"] as? String ?? ""
                let lo = d["nominal_pinjaman"] as? String ?? ""
                new.append([id,lo])
            }
            
            self.pinjaman = new
        }
        
        if let product = data["products"] as? [Dictionary<String,Any>]{
            var new = [[String]]()
            
            for d in product{
                let id = d["Product_id"] as? String ?? ""
                let lo = d["Loan_term"] as? String ?? ""
                new.append([id,lo])
            }
            
            self.products = new
        }
    }
    
    func convertPinjamanPicker() -> [[String:String]]{
        var a = [[String:String]]()
        for p in self.pinjaman{
            let cn = "Rp \(BKDNCurrency.formatCurrency(UInt32(p[1]) ?? 0))"
            a.append(["title":cn])
        }
        return a
    }
    
    func convertProductsPicker() -> [[String:String]]{
        var a = [[String:String]]()
        for p in self.products{
            let cn = p[1] + " Hari"
            let id = p[0]
            a.append(["title":cn, "id": id])
        }
        return a
    }
    
    func getID(str: String) -> String{
        var id = ""
        for p in self.products{
            let cn = p[1] + " Hari"
            if str == cn{
                id = p[0]
                break
            }
        }
        return id
    }
}
