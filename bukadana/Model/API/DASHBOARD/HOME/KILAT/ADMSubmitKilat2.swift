//
//  ADMSubmitKilat2.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADMSubmitKilat2Protocol {
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ()))
}

class ADMSubmitKilat2: ADMSubmitKilat2Protocol {
    let api = API()
    var param = Dictionary<String, Any>()
    
    func submit(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.PSubmitKilat2)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: param, method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADMSubmitKilat2 {
    func setParam(model: [MFormText]){
        param["pendidikan"]       = BKDNDataArray.getIndexPendidikan(str: model[0].content)
        param["nama_perusahaan"]  = model[1].content
        param["telp_perusahaan"]  = model[2].content
        param["status_karyawan"]  = model[3].content
        param["lama_bekerja"]     = model[4].content
        param["nama_atasan"]      = model[5].content
        param["referensi_nama_1"] = model[6].content
        param["referensi_1"]      = model[7].content
        param["referensi_nama_2"] = model[8].content
        param["referensi_2"]      = model[9].content
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
