//
//  VCRegister.swift
//  bukadana
//
//  Created by Gaenael on 12/30/18.
//  Copyright © 2018 Gaenael. All rights reserved.
//

import UIKit
import AccountKit

class VCRegister: UIViewController {

    @IBOutlet weak var vwHeader: BKDNVHeader!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var modelAPIPeminjam : AARegisterPeminjam = AARegisterPeminjam()
    var modelAPIPendana  : AARegisterPendana  = AARegisterPendana()
    
    var _accountKit: AKFAccountKit!
    
    var countryCode = "+62"
    
    var fullname   = ""
    var telp       = ""
    var email      = ""
    var password   = ""
    var type       = "Peminjam"
    var sdana      = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if _accountKit?.currentAccessToken != nil {
            // if the user is already logged in, go to the main screen
            // ...
        }
        else {
            // Show the login screen
        }
    }
    
    func configUI(){
        bgImage.image = UIImage(named: "bg")
        vwHeader.addBackButton()
        vwHeader.button1.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        vwHeader.setStyle1(title: "Daftar Member", desc: "Buat akun untuk member bukadana")
        
        BKDNView.registerNibTableView(tblView: self.tableView, nibName: "TVCRegisterForm")
        tableView.delegate       = self
        tableView.dataSource     = self
        tableView.separatorStyle = .none
        
        if _accountKit == nil {
            _accountKit = AKFAccountKit(responseType: .accessToken)
        }
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension VCRegister: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCRegisterForm") as? TVCRegisterForm
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 502
    }
}

extension VCRegister: TVCRegisterFormDelegate{
    func changeType(type: String) {
        let section = IndexSet(integer: 0)
        self.tableView.reloadSections(section, with: .fade)
    }
    
    func toOtp() {
        self.performSegue(withIdentifier: "toOtp", sender: nil)
    }
    
    func register(fname: String, telp: String, email: String, pass: String, type: String, sdana: String) {
        var msg = ""
        if telp.count == 0{
            msg = "Nomor telepon tidak boleh kosong"
        }
        else if !BKDNValidate.checkPassword(pass: pass){
            msg = "Password harus 8 karater dengan kombinasi Huruf besar, Huruf kecil dan Angka"
        }
        
        if msg.count == 0{
            self.telp     = telp
            self.type     = type
            self.email    = email
            self.fullname = fname
            self.password = pass
            self.sdana    = sdana
            
            self.loginWithPhone()
        }
        else{
            let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func regPeminjam(fname: String, telp: String, email: String, pass: String){
        self.modelAPIPeminjam.setObj(fname: fname, telp: telp, email: email, pass: pass)
        self.modelAPIPeminjam.register { (data, err) in
            self.handleRes(data: data, err)
        }
    }
    
    func regPendana(fname: String, telp: String, email: String, pass: String, sdana: String){
        self.modelAPIPendana.setObj(fname: fname, telp: telp, email: email, pass: pass, sdana: sdana)
        self.modelAPIPendana.register { (data, err) in
            self.handleRes(data: data, err)
        }
    }
    
    func handleRes(data:Dictionary<String,Any>,_ err: BKDNAPIError?){
        if err?.msg == nil{
            let alert = BKDNAlert.showAlertSuccess(title: "", msg: "Register Success", action: { (action) in
                self.back()
            })
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension VCRegister: AKFViewControllerDelegate{
    func loginWithPhone(){
        let inputState = UUID().uuidString
        
        var phoneTemp = self.telp
        if let abc = self.telp.character(at: 0){
            if abc == "0"{
                phoneTemp.remove(at: phoneTemp.startIndex)
            }
        }
        
        let number = AKFPhoneNumber.init(countryCode: countryCode, phoneNumber: phoneTemp)
        
        let vc = (_accountKit?.viewControllerForPhoneLogin(with: number, state: inputState))!
        vc.enableSendToFacebook = true
        self.prepareLoginViewController(loginViewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    func prepareLoginViewController(loginViewController: AKFViewController) {
        loginViewController.delegate = self
        //UI Theming - Optional
        print("prepareLoginViewController")
        loginViewController.uiManager = AKFSkinManager(skinType: .translucent, primaryColor: UIColor.blue)
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didFailWithError error: Error!) {
        // ... implement appropriate error handling ...
        print("\(String(describing: viewController)) did fail with error: \(error.localizedDescription)")
    }
    
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)!) {
        print("viewControllerDidCancel")
        // ... handle user cancellation of the login process ...
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        switch self.type {
        case "Pendana":
            regPendana(fname: self.fullname, telp: self.telp, email: self.email, pass: self.password, sdana: sdana)
        default:
            regPeminjam(fname: self.fullname, telp: self.telp, email: self.email, pass: self.password)
        }
    }
    
}
