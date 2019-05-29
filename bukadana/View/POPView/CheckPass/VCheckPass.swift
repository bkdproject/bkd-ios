//
//  VCheckPass.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol VCheckPassDelegate {
    func success()
}

class VCheckPass: UIViewController {

    var delegate: VCheckPassDelegate?
    
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    func setup(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        BKDNView.radius(vw: self.vwContent, rad: 8)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.txtPassword.becomeFirstResponder()
    }
    
    @IBAction func actionCheck(_ sender: Any) {
        postApi()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func postApi(){
        let api  = AACheckPass()
        api.pass = self.txtPassword.text ?? ""
        api.postApi { (msg, err) in
            if err == nil{
                self.dismiss(animated: true, completion: {
                    self.delegate?.success()
                })
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Password Salah")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
