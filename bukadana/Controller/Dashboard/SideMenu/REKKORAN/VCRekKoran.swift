//
//  VCHistory.swift
//  bukadana
//
//  Created by Gaenael on 1/29/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCRekKoran: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    var arrData = [Dictionary<String, Any>]()
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var vwHeader: BKDNVHeader!
    
    var refresh = BKDNRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI(){
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCRekKoran")
        
        self.tblView.delegate       = self
        self.tblView.dataSource     = self
        self.tblView.separatorStyle = .none
        
        bgImg.image = UIImage(named: "bg")
        vwHeader.setStyle4WithBack(title: "Rekening Koran", desc: "")
        vwHeader.button1.addTarget(self, action: #selector(actionButton1), for: .touchUpInside)
        
        getList()
        
        refresh.delegate = self
        refresh.addRefresh(tableView: tblView)
    }
    
    @objc func actionButton1(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func getList(){
        let api = ADRList()
        api.getData { (data, err) in
            self.refresh.stopAnimation()
            if err == nil{
                self.arrData = data
                self.tblView.reloadData()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Failed", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension VCRekKoran: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCRekKoran") as? TVCRekKoran
        cell?.setData(data: data)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension VCRekKoran: BKDNRefreshControlDelegate{
    func actionRefresh() {
        getList()
    }
}
