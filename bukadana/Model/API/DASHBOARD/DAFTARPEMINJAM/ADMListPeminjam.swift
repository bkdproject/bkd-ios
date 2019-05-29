//
//  ADMListPeminjam.swift
//  bukadana
//
//  Created by Gaenael on 2/25/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADMListPeminjamProtocol {
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ()))
}

class ADMListPeminjam: ADMListPeminjamProtocol {
    let api = API()
    
    var limit = 10
    var page  = 0
    
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.PEMINJAMLIST) + getParam()
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .get, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADMListPeminjam {
    func getParam() -> String{
        return "?limit=\(limit)&page=\(page)"
    }
    
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> [Dictionary<String,Any>]{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["content"] as? Dictionary<String,Any>{
                if let list_peminjam = content["list_peminjam"] as? [Dictionary<String,Any>]{
                    return list_peminjam
                }
                else{
                    return [Dictionary<String,Any>]()
                }
            }
            else{
                return [Dictionary<String,Any>]()
            }
        }
        else{
            return [Dictionary<String,Any>]()
        }
    }
}
