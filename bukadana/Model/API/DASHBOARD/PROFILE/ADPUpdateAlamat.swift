//
//  ADPUpdateAlamat.swift
//  bukadana
//
//  Created by Gaenael on 2/21/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADPUpdateAlamatProtocol {
    func getData(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ()))
}

class ADPUpdateAlamat: ADPUpdateAlamatProtocol {
    let api = API()
    var param = Dictionary<String, Any>()
    func getData(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.UPDATEINFOALAM)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: param, method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADPUpdateAlamat {
    func setParam(almt: String, kota: String, prov: String, kodepos: String){
        param["member_id"] = BKDNUserDataModel.getData().member_id ?? ""
        param["alamat"]    = almt
        param["kota"]      = kota
        param["provinsi"]  = prov
        param["kodepos"]   = kodepos
    }
    
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> String{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["message"] as? String{
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
