
//
//  APILPengajuanMikro.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol APILPengajuanMikroProtocol {
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ()))
}

class APILPengajuanMikro: APILPengajuanMikroProtocol {
    let api = API()
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.PengMikro)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .post, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension APILPengajuanMikro {
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
