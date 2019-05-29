//
//  ADTPendanaanSubmit.swift
//  bukadana
//
//  Created by Gaenael on 3/5/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADTPendanaanSubmitProtocol {
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ()))
}

class ADTPendanaanSubmit: ADTPendanaanSubmitProtocol {
    let api = API()
    var param = Dictionary<String, Any>()
    
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.PENDSUBMIT)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: param, method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADTPendanaanSubmit {
    func setParam(no: String, jml: String){
        param["transaksi_id"]       = no
        param["nominal_pendanaan"]  = jml
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
