//
//  ADMSubmitKilat3.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import Alamofire

protocol ADMSubmitKilat3Protocol {
    func uploadPhoto(completion: @escaping ((String, BKDNAPIError?) -> ()))
}

class ADMSubmitKilat3: ADMSubmitKilat3Protocol {
    let api        =  API()
    
    var paramImage = [Dictionary<String, Any>()]
    var param      = [String:String]()
    
    func uploadPhoto(completion: @escaping ((String, BKDNAPIError?) -> ())) {
        
        let host   = BKDNConfig.getHost(url: BKDNUrl.PSubmitKilat3)
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
                    BKDNLog.log(str: "ADMSubmitKilat3: progress\(progress)", types: .other)
                })
                
                upload.responseJSON { response in
                    BKDNLog.log(str: "ADMSubmitKilat3: response\(response.result.value ?? "")", types: .other)
                    let datas = self.handleResponse(JSON: response.result.value)
                    completion(datas, nil)
                }
                
            case .failure(_):
                break
            }
        }
    }
}

extension ADMSubmitKilat3 {
    func setParam(model: [MFormText]){
        var jmlPinjam = model[3].content.replacingOccurrences(of: "Rp ", with: "")
        jmlPinjam     = jmlPinjam.replacingOccurrences(of: ",", with: "")
        
        param["nomor_rekening"]  = model[2].content
        param["jumlah_pinjaman"] = jmlPinjam
        param["product_id"]      = MOList.shared?.kilat.getID(str: model[4].content) 
        param["gaji"]            = model[6].content
        
        print(param)
    }
    
    func setParamImage(model: [MFormText]){
        var dict    = Dictionary<String, Any>()
        
        dict["key"]  = "foto_file"
        dict["img"]  = model[0].image
        dict["name"] = "foto_file.jpg"
        paramImage.append(dict)
        
        dict["key"]  = "nik_file"
        dict["img"]  = model[1].image
        dict["name"] = "nik_file.jpg"
        paramImage.append(dict)
        
        dict["key"]  = "foto_surat_ket_kerja"
        dict["img"]  = model[5].image
        dict["name"] = "foto_surat_ket_kerja.jpg"
        paramImage.append(dict)
        
        dict["key"]  = "foto_slip_gaji"
        dict["img"]  = model[7].image
        dict["name"] = "foto_slip_gaji.jpg"
        paramImage.append(dict)
        
        dict["key"]  = "foto_pegang_idcard"
        dict["img"]  = model[8].image
        dict["name"] = "foto_pegang_idcard.jpg"
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
