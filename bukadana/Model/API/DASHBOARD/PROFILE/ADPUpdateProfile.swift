//
//  ADPUPDATEPROFILE.swift
//  bukadana
//
//  Created by Gaenael on 2/21/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADPUpdateProfileProtocol {
    func getData(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ()))
}

class ADPUpdateProfile: ADPUpdateProfileProtocol {
    let api = API()
    var param = Dictionary<String, Any>()
    
    func getData(completion:@escaping ((_ msg:String,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.UPDATEINFOAKUN)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: param, method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADPUpdateProfile {
    func setParam(fname: String, Nomor_nik: String, Jenis_kelamin: String, Tanggal_lahir: String, email: String, telp: String, pendidikan: String, pekerjaan: String, norek: String, nb: String){
        param["fullname"]       = fname
        param["email"]          = email
        param["telp"]           = telp
        param["nomor_rekening"] = norek
        param["nama_bank"]      = nb
        param["nik"]            = Nomor_nik
        param["jenis_kelamin"]  = Jenis_kelamin
        param["tgl_lahir"]      = Tanggal_lahir
        param["pendidikan"]     = BKDNDataArray.getIndexPendidikan(str: pendidikan)
        param["pekerjaan"]      = BKDNDataArray.getIndexPekerjaan(str: pekerjaan)
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
