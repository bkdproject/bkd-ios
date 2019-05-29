//
//  AALogin.swift
//  bukadana
//
//  Created by Gaenael on 1/30/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol AALoginProtocol {
    func login(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ()))
}

class AALogin: AALoginProtocol {
    let api = API()
    
    var uname = ""
    var pass  = ""
    
    func login(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ())) {
        let host  = BKDNConfig.getHost(url: BKDNUrl.login)
        let param = self.convertObjToParam()
        
        api.getApi(url: host, parameters: param, method: .post, header: [:]) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension AALogin {
    func setObj(uname: String, pass: String){
        self.uname = uname
        self.pass  = pass
    }
    
    func convertObjToParam() -> Dictionary<String,Any>{
        var param = Dictionary<String,Any>()
        param["username"] = self.uname
        param["password"] = self.pass
        
        return param
    }
    
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> Dictionary<String,Any>{
        if let js = JSON as? Dictionary<String,Any>{
            let token = js["token"] as? String
            let type  = js["logtype"] as? String
            BUserKeyModel.save(token: token, type: type)
            return js
        }
        else{
            return Dictionary<String,Any>()
        }
    }
}
