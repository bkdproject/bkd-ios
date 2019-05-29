//
//  AARegister.swift
//  bukadana
//
//  Created by Gaenael on 2/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol AARegisterPeminjamProtocol {
    func register(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ()))
}

class AARegisterPeminjam: AARegisterPeminjamProtocol {
    let api = API()
    
    var fullname   = ""
    var telp       = ""
    var email      = ""
    var password   = ""
    var type       = 1
    
    func register(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ())) {
        let host  = BKDNConfig.getHost(url: BKDNUrl.regPeminjam)
        let param = self.convertObjToParam()
        
        api.getApi(url: host, parameters: param, method: .post, header: [:]) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension AARegisterPeminjam {
    func setObj(fname: String, telp: String, email: String, pass: String){
        self.fullname   = fname
        self.telp       = telp
        self.email      = email
        self.password   = pass
    }
    
    func convertObjToParam() -> Dictionary<String,Any>{
        var param = Dictionary<String,Any>()
        param["fullname"] = self.fullname
        param["telp"]     = self.telp
        param["email"]    = self.email
        param["password"] = self.password
        param["type"]     = self.type
        
        return param
    }
    
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> Dictionary<String,Any>{
        if let js = JSON as? Dictionary<String,Any>{
            return js
        }
        else{
            return Dictionary<String,Any>()
        }
    }
}
