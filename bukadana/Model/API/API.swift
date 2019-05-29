//
//  API.swift
//  bukadana
//
//  Created by Gaenael on 1/30/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import Alamofire

var AFManager = SessionManager()

class API: NSObject {
    
    typealias BAPICompletion = ((_ error:BKDNAPIError?,_ json:Any?) -> ())
    
    func getApi(url:String, parameters: Parameters, isJson :Bool=true, method: HTTPMethod, header:[String:String], withAlert:UIViewController?=nil, completion: @escaping BAPICompletion){
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest  = 15 // seconds
        configuration.timeoutIntervalForResource = 15 //seconds
        AFManager = Alamofire.SessionManager(configuration: configuration)
        
//        BKDNLog.log(str: url, types: .url)               //Log----
//        BKDNLog.log(str: "\(parameters)", types: .param) //Log----
//        BKDNLog.log(str: "\(header)", types: .varia)     //Log----
        
        let newEncoding : ParameterEncoding = URLEncoding.default
        
        Alamofire.request(url, method: method, parameters:parameters, encoding: newEncoding , headers: header).responseJSON { response in
            switch (response.result){
            case .success(let JSON):
                self.handle(res: JSON, completion: completion)
            case .failure(_):
                let errObj = BKDNAPIError.init()
                errObj.msg = "Check your internet connection"
                completion(errObj, nil)
            }
        }
        
    }
    
    func handle(res:Any, completion:@escaping BAPICompletion){
        if let res = res as? Dictionary<String,Any> {
            if let status = res["status"] as? Int{
                if status == 200{
                    let response = res["response"] as? String ?? ""
                    switch response{
                    case "success":
                        completion(nil, res)
                    default:
                        let errObj = BKDNAPIError.init()
                        errObj.msg = res["message"] as? String ?? ""
                        completion(errObj, nil)
                    }
                }
                else if status == 401{
                    if BUserKeyModel.checkUser(){
                        BUserKeyModel.logout()
                        self.changeRoot()
                    }
                    else{
                        let errObj = BKDNAPIError.init()
                        errObj.msg = res["message"] as? String ?? ""
                        completion(errObj, nil)
                    }
                }
                else{
                    let errObj = BKDNAPIError.init()
                    errObj.msg = res["message"] as? String ?? ""
                    completion(errObj, nil)
                }
            }
            else{
                let errObj = BKDNAPIError.init()
                errObj.msg = "Check your internet connection"
                completion(errObj, nil)
            }
        }
    }
}


extension API{
    private func changeRoot(){
        let vc = BKDNController.getControllerFrom(storyoard: "Auth", identifier: "NavAuth") as! UINavigationController
        BKDNController.changeRoot(vc: vc)
    }
}
