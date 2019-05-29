//
//  ADTD.swift
//  bukadana
//
//  Created by Gaenael on 3/2/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

protocol ADTDProtocol {
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ()))
}

class ADTD: ADTDProtocol {
    let api = API()
    
    var no = ""
    
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ())) {
        
        let host = BKDNConfig.getHost(url: BKDNUrl.TPeminjamDetail) + getParam()
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .get, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADTD {
    func getParam() -> String{
        return "?t=\(self.no)"
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
