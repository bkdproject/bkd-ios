//
//  AACheckPass.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol AACheckPassProtocol {
    func postApi(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ()))
}

class AACheckPass: AACheckPassProtocol {
    let api = API()
    
    var pass = ""
    
    func postApi(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ())) {
        let host  = BKDNConfig.getHost(url: BKDNUrl.CEKPASS)
        let param = self.convertObjToParam()
        
        api.getApi(url: host, parameters: param, method: .post, header: [:]) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension AACheckPass {
    func convertObjToParam() -> Dictionary<String,Any>{
        var param = Dictionary<String,Any>()
        
        param["username"] = BKDNUserDataModel.getData().email ?? ""
        param["password"] = pass
        
        return param
    }
    
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> String{
        if let js = JSON as? Dictionary<String,Any>{
            if let response = js["response"] as? String{
                return response
            }
            else{
                return ""
            }
        }
        else{
            return ""
        }
    }
}


