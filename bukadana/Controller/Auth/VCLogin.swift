//
//  VCLogin.swift
//  bukadana
//
//  Created by Gaenael on 12/30/18.
//  Copyright © 2018 Gaenael. All rights reserved.
//

import UIKit

protocol VCLoginDelegate {
    func toDaftar()
}

class VCLogin: UIViewController {

    var delegate: VCLoginDelegate?
    @IBOutlet weak var vwHeader: BKDNVHeader!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgImg: UIImageView!
    
    var modelAPI: AALogin = AALogin()
    var loading = VHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    
    func configUI(){
        bgImg.image = UIImage(named: "bg")
        vwHeader.addBackButton()
        vwHeader.button1.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        vwHeader.setStyle1(title: "Login Form", desc: "Login Form untuk member bukadana")
        
        BKDNView.registerNibTableView(tblView: self.tableView, nibName: "TVCLoginForm")
        tableView.delegate       = self
        tableView.dataSource     = self
        tableView.separatorStyle = .none
        
        loading.loadViewFromNib(nib: .loading)
        loading.frame = CGRect(x: 0, y: 0, width: BKDNFrame.getWidht(), height: BKDNFrame.getHeight())
        loading.setupLoading()
        self.view.addSubview(loading)
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension VCLogin: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCLoginForm") as? TVCLoginForm
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 324
    }
}

extension VCLogin: TVCLoginFormDelegate{
    func login(name: String, pass: String) {
        loading.startLoading()
        self.modelAPI.setObj(uname: name, pass: pass)
        self.modelAPI.login { (data, err) in
            self.loading.stopLoading()
            if err?.msg == nil{
                let alert = BKDNAlert.showAlertSuccess(title: "Info", msg: "Login Success", action: { (action) in
                    self.changeRoot()
                })
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func toDaftar() {
        self.delegate?.toDaftar()
    }
    
    private func changeRoot(){
        let vc = BKDNController.getControllerFrom(storyoard: "Dashboard", identifier: "SideMenu") 
        BKDNController.changeRoot(vc: vc)
    }
}
