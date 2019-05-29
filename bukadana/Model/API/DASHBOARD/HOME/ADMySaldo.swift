//
//  ADMySaldo.swift
//  bukadana
//
//  Created by Gaenael on 2/9/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADMySaldoProtocol {
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ()))
}

class ADMySaldo: ADMySaldoProtocol {
    let api = API()
    
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.mysaldo)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension ADMySaldo {
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> Dictionary<String,Any>{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["content"] as? Dictionary<String,Any>{
                BKDNUserSaldoModel.save(data: content)
                return js
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

