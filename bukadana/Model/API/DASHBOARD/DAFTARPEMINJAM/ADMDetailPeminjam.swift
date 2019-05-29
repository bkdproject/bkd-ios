//
//  ADMDetailPeminjam.swift
//  bukadana
//
//  Created by Gaenael on 3/4/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADMDetailPeminjamProtocol {
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ()))
}

class ADMDetailPeminjam: ADMDetailPeminjamProtocol {
    let api = API()
    
    var no = ""
    
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.PEMINJAMDETAIL) + getParam()
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .get, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADMDetailPeminjam {
    func getParam() -> String{
        return "?t=\(no)"
    }
    
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> Dictionary<String,Any>{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["content"] as? Dictionary<String,Any>{
                return content
            }
            else{
                return Dictionary<String,Any>()
            }
        }
        else{
            return Dictionary<String,Any>()
        }
    }
}

