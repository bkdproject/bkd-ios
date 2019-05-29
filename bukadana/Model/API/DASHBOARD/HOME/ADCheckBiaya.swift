//
//  ADCheckBiaya.swift
//  bukadana
//
//  Created by Gaenael on 5/15/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol ADCheckBiayaProtocol {
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ()))
}

class ADCheckBiaya: ADCheckPinjamanProtocol {
    let api = API()
    
    func getData(completion:@escaping ((_ data:Dictionary<String,Any>,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.CEKBIAYA)
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .get, header: header) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            
            completion(datas, err)
        }
    }
}

extension ADCheckBiaya {
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> Dictionary<String,Any>{
        if let js = JSON as? Dictionary<String,Any>{
            return js
        }
        else{
            return Dictionary<String,Any>()
        }
    }
}

