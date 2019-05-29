//
//  ADTList.swift
//  bukadana
//
//  Created by Gaenael on 2/17/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

protocol ADTListProtocol {
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ()))
}

class ADTList: ADTListProtocol {
    let api = API()
    
    func getData(completion:@escaping ((_ data:[Dictionary<String,Any>],_ err: BKDNAPIError?) -> ())) {
        
        var host = ""
        if self.checkISPendana(){
            host = BKDNConfig.getHost(url: BKDNUrl.TPendanaList)
        }
        else{
            host = BKDNConfig.getHost(url: BKDNUrl.TPeminjamList)
        }
        
        let header = BKDNHTTPHeader.getHeaderAccess()
        
        api.getApi(url: host, parameters: [:], method: .get, header: header) { (err, json) in
            var datas = [Dictionary<String,Any>()]
            if self.checkISPendana(){
                datas = self.handleResponsePendana(err: err, JSON: json)
            }
            else{
                datas = self.handleResponsePeminjam(err: err, JSON: json)
            }
            
            completion(datas, err)
        }
    }
}

extension ADTList {
    func handleResponsePeminjam(err:BKDNAPIError?, JSON:Any?) -> [Dictionary<String,Any>]{
        if let js = JSON as? Dictionary<String,Any>{
            if let list_transaksi = js["list_transaksi"] as? [Dictionary<String,Any>]{
                return list_transaksi
            }
            else{
                return [Dictionary<String,Any>()]
            }
        }
        else{
            return [Dictionary<String,Any>()]
        }
    }
    
    func handleResponsePendana(err:BKDNAPIError?, JSON:Any?) -> [Dictionary<String,Any>]{
        if let js = JSON as? Dictionary<String,Any>{
            if let content = js["content"] as? Dictionary<String,Any>{
                if let list_transaksi = content["list_transaksi"] as? [Dictionary<String,Any>]{
                    return list_transaksi
                }
                else{
                    return [Dictionary<String,Any>()]
                }
            }
            else{
                return [Dictionary<String,Any>()]
            }
        }
        else{
            return [Dictionary<String,Any>()]
        }
    }
    
    func checkISPendana() -> Bool{
        let type = typeUser.init(rawValue: BUserKeyModel.getType()) ?? .peminjam
        switch type {
        case .peminjam:
            return false
        default:
            return true
        }
    }
}
