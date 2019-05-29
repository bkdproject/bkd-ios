//
//  ALProvinsi.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol APILProvinsiProtocol {
    func getData(completion:@escaping ((_ data:Bool,_ err: BKDNAPIError?) -> ()))
}

class APILProvinsi: APILProvinsiProtocol {
    let api = API()
    func getData(completion:@escaping ((_ data:Bool,_ err: BKDNAPIError?) -> ())) {
        let host   = BKDNConfig.getHost(url: BKDNUrl.PProvinsiList)
        
        api.getApi(url: host, parameters: [:], method: .get, header: [:]) { (err, json) in
            let datas = self.handleResponse(err: err, JSON: json)
            completion(datas, err)
        }
    }
}

extension APILProvinsi {
    func handleResponse(err:BKDNAPIError?, JSON:Any?) -> Bool{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["content"] as? [Dictionary<String,Any>]{
                self.converTOArr(data: content)
                return true
            }
            else{
                return false
            }
        }
        else{
            return false
        }
    }
    
    func converTOArr(data: [Dictionary<String,Any>]){
        var arr = [[String:String]]()
        for d in data{
            let a = d["province_name"] as? String ?? ""
            arr.append(["title": a])
        }
        MOList.shared?.province = arr
    }
}
