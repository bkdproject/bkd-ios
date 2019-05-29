//
//  ADRDSubmit.swift
//  bukadana
//
//  Created by Gaenael on 2/24/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADRDSubmitProtocol {
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ()))
}

class ADRDSubmit: ADRDSubmitProtocol {
    let api = API()
    var param = Dictionary<String, Any>()
    
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.REDEEMSUBMIT)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: param, method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADRDSubmit {
    func setParam(no: String, bank: String, jml: String){
        param["nomor_rekening"] = no
        param["nama_bank"]      = bank
        param["jml_redeem"]     = jml
    }
    
    private func handleResponse(err:BKDNAPIError?, JSON:Any?) -> String{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["content"] as? String{
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
