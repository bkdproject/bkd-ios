//
//  ADMSubmitMikro1.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADMSubmitMikro1Protocol {
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ()))
}

class ADMSubmitMikro1: ADMSubmitMikro1Protocol {
    let api = API()
    var param = Dictionary<String, Any>()
    
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.PSubmitMikro1)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: param, method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADMSubmitMikro1 {
    func setParam(model: [MFormText]){
        param["tempat_lahir"]  = model[0].content
        param["jenis_kelamin"] = model[1].content
        param["alamat"]        = model[2].content
        param["kota"]          = model[3].content
        param["provinsi"]      = model[4].content
        param["kodepos"]       = model[5].content
    }
    
    private func handleResponse(err:BKDNAPIError?, JSON:Any?) -> String{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["response"] as? String{
                return content
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
