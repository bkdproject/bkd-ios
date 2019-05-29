//
//  ADMSubmitMikro3.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import Alamofire

protocol ADMSubmitMikro3Protocol {
    func uploadPhoto(completion: @escaping ((String, BKDNAPIError?) -> ()))
}

class ADMSubmitMikro3: ADMSubmitMikro3Protocol {
    let api        =  API()
    
    var paramImage = [Dictionary<String, Any>()]
    var param      = [String:String]()
    
    func uploadPhoto(completion: @escaping ((String, BKDNAPIError?) -> ())) {
        
        let host   = BKDNConfig.getHost(url: BKDNUrl.PSubmitMikro3)
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
                    BKDNLog.log(str: "ADMSubmitMikro3: progress\(progress)", types: .other)
                })
                
                upload.responseJSON { response in
                    BKDNLog.log(str: "ADMSubmitMikro3: response\(response.result.value ?? "")", types: .other)
                    let datas = self.handleResponse(JSON: response.result.value)
                    let err   = self.handleResponseErr(JSON: response.result.value)
                    completion(datas, err)
                }
                
            case .failure(_):
                break
            }
        }
    }
}

extension ADMSubmitMikro3 {
    func setParam(model: [MFormText]){
        param["pekerjaan"]          = BKDNDataArray.getIndexPekerjaan(str: model[1].content)
        param["nomor_nik"]          = model[2].content
        param["nomor_rekening"]     = model[4].content
        param["usaha"]              = model[5].content
        param["lama_usaha"]         = model[7].content
        param["jumlah_pinjaman"]    = model[8].content
        param["product_id"]         = MOList.shared?.mikro.getID(str: model[9].content)
    }
    
    func setParamImage(model: [MFormText]){
        var dict    = Dictionary<String, Any>()
        
        dict["key"]  = "foto_file"
        dict["img"]  = model[0].image
        dict["name"] = "foto_file.jpg"
        paramImage.append(dict)
        
        dict["key"]  = "nik_file"
        dict["img"]  = model[3].image
        dict["name"] = "nik_file.jpg"
        paramImage.append(dict)
        
        dict["key"]  = "foto_usaha_file"
        dict["img"]  = model[6].image
        dict["name"] = "foto_usaha_file.jph"
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
    
    private func handleResponseErr(JSON:Any?) -> BKDNAPIError?{
        if let js = JSON as? Dictionary<String,Any>{
            if let response = js["response"] as? Dictionary<String,Any>{
                let errObj = BKDNAPIError.init()
                errObj.msg = response["message"] as? String ?? ""
                
                return errObj
            }
            else{
                let errObj = BKDNAPIError.init()
                errObj.msg = js["message"] as? String ?? ""
                
                return errObj
            }
        }
        else{
            return BKDNAPIError.init()
        }
    }
}


