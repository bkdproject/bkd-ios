//
//  ADDataTransaksi.swift
//  bukadana
//
//  Created by Gaenael on 2/25/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADDataTransaksiProtocol {
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ()))
}

class ADDataTransaksi: ADDataTransaksiProtocol {
    let api = API()
    
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.datatrans)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .get, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            
            completion(datas, err)
        }
    }
}

extension ADDataTransaksi {
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> [Dictionary<String,Any>]{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["content"] as? Dictionary<String,Any>{
                if let repayment = content["list_repayment"] as? [Dictionary<String,Any>]{
                    return repayment
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

