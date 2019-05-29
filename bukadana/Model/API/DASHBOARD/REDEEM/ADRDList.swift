//
//  ADRDList.swift
//  bukadana
//
//  Created by Gaenael on 2/24/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADRDListProtocol {
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ()))
}

class ADRDList: ADRDListProtocol {
    let api = API()
    
    var limit = 10
    var page  = 1
    
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.REDEEMLIST)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .get, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADRDList {
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
