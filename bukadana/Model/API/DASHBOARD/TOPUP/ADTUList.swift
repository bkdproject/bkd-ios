
//
//  ADTUList.swift
//  bukadana
//
//  Created by Gaenael on 2/17/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADTUListProtocol {
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ()))
}

class ADTUList: ADTUListProtocol {
    let api = API()
    
    var limit = 10
    var page  = 1
    
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.TPUList) + self.getParam()
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .get, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADTUList {
    func getParam() -> String{
        return "?limit=\(limit)&page=\(page)"
    }
    
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> [Dictionary<String,Any>]{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["content"] as? [Dictionary<String,Any>]{
                return content
            }
            else{
                return [Dictionary<String,Any>()]
            }
        }
        else{
            return [Dictionary<String,Any>()]
        }
    }
}

