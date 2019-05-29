//
//  ADTPinjamanSubmit.swift
//  bukadana
//
//  Created by Gaenael on 3/5/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import Alamofire

protocol ADTPinjamanSubmitProtocol {
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ()))
}

class ADTPinjamanSubmit: ADTPinjamanSubmitProtocol {
    let api = API()
    var param = Dictionary<String, Any>()
    
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.PEMBSUBMIT)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: param, method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADTPinjamanSubmit {
    func setParam(no: String, jml: String){
        param["transaksi_id"] = no
        param["jml_bayar"]    = jml
    }
    
    private func handleResponse(err:BKDNAPIError?, JSON:Any?) -> String{
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
