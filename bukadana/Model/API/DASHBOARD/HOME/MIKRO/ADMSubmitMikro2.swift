//
//  ADMSubmitMikro2.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import Alamofire

protocol ADMSubmitMikro2Protocol {
    func uploadPhoto(completion: @escaping ((String, BKDNAPIError?) -> ()))
}

class ADMSubmitMikro2: ADMSubmitMikro2Protocol {
    let api        =  API()
    
    var paramImage = [Dictionary<String, Any>()]
    var param      = [String:String]()
    
    func uploadPhoto(completion: @escaping ((String, BKDNAPIError?) -> ())) {
        
        let host   = BKDNConfig.getHost(url: BKDNUrl.PSubmitMikro2)
        let header = BKDNHTTPHeader.getHeaderAccessEncode()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            //MARK: Image
            for a in self.paramImage{
                let key = a["key"] as? String ?? ""
                let nam = a["name"] as? String ?? ""
                
                if let img = a["img"] as? UIImage{
                    let dt = img.jpegData(compressionQuality: 0.50)!
                    multipartFormData.append(dt, withName: key,fileName: nam, mimeType: "file")
                }
                else{
                    multipartFormData.append(Data(), withName: key,fileName: nam, mimeType: "file")
                }
            }
            
            
            //MARK: String
            for (key, value) in self.param {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to:host, method: .post, headers:header)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                    BKDNLog.log(str: "ADMSubmitMikro2: progress\(progress)", types: .other)
                })
                
                upload.responseJSON { response in
                    BKDNLog.log(str: "ADMSubmitMikro2: response\(response.result.value ?? "")", types: .other)
                    let datas = self.handleResponse(JSON: response.result.value)
                    completion(datas, nil)
                }
                
            case .failure(_):
                break
            }
        }
    }
}

extension ADMSubmitMikro2 {
    func setParam(model: [MFormText]){
        param["deskripsi_usaha"]   = model[0].content
        param["omzet"]             = model[2].content
        param["margin"]            = model[3].content
        param["biaya_operasional"] = model[4].content
        param["laba_usaha"]        = model[5].content
        param["jml_bunga"]         = "0"
        param["nama_bank"]         = model[7].content
    }
    
    func setParamImage(model: [MFormText]){
        var dict    = Dictionary<String, Any>()
        dict["key"]  = "info_usaha_file"
        dict["img"]  = model[1].image
        dict["name"] = "info_usaha_file.jpg"
        paramImage.append(dict)
    }
    
    private func handleResponse(JSON:Any?) -> String{
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


