//
//  AARegisterPendana.swift
//  bukadana
//
//  Created by Gaenael on 2/2/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol AARegisterPendanaProtocol {
    func register(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ()))
}

class AARegisterPendana: AARegisterPendanaProtocol {
    let api = API()
    
    var fullname   = ""
    var telp       = ""
    var email      = ""
    var password   = ""
    var sumberdana = ""
    
    func register(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ())) {
        let host  = BKDNConfig.getHost(url: BKDNUrl.regPendana)
        let param = self.convertObjToParam()
        
        api.getApi(url: host, parameters: param, method: .post, header: [:]) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension AARegisterPendana {
    func setObj(fname: String, telp: String, email: String, pass: String, sdana: String){
        self.fullname   = fname
        self.telp       = telp
        self.email      = email
        self.password   = pass
        self.sumberdana = sdana
    }
    
    func convertObjToParam() -> Dictionary<String,Any>{
        var param = Dictionary<String,Any>()
        
        param["fullname"]   = self.fullname
        param["telp"]       = self.telp
        param["email"]      = self.email
        param["password"]   = self.password
        param["sumberdana"] = self.sumberdana
        
        return param
    }
    
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> Dictionary<String,Any>{
        if let js = JSON as? Dictionary<String,Any>{
            BKDNLog.log(str: "\(js)", types: .json)
            return js
        }
        else{
            BKDNLog.log(str: "\(err?.msg ?? "")", types: .err)
            return Dictionary<String,Any>()
        }
    }
}


