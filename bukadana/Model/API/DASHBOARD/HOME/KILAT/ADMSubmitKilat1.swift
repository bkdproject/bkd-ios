//
//  ADMKilatInformPribadi.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADMSubmitKilat1Protocol {
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ()))
}

class ADMSubmitKilat1: ADMSubmitKilat1Protocol {
    let api = API()
    var param = Dictionary<String, Any>()
    
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.PSubmitKilat1)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: param, method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADMSubmitKilat1 {
    func setParam(model: [MFormText]){
        param["tempat_lahir"]  = model[0].content
        param["jenis_kelamin"] = model[1].content
        param["tanggal_lahir"] = model[2].content
        param["alamat"]        = model[3].content
        param["kota"]          = model[4].content
        param["provinsi"]      = model[5].content
        param["kodepos"]       = model[6].content
        param["pekerjaan"]     = BKDNDataArray.getIndexPekerjaan(str: model[7].content) 
        param["no_nik"]        = model[8].content
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
