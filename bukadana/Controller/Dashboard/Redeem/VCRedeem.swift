//
//  VCRedeem.swift
//  bukadana
//
//  Created by Gaenael on 2/15/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCRedeem: UIViewController {

    var model   = ADRDList()
    var refresh = BKDNRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var vwHeader: BKDNVHeader!
    
    var arrRedeem = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()
    }
    
    func config(){
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        
        tableView.separatorStyle = .none
        vwHeader.setStyle4(title: "Redeem", desc: "Untuk Penebusan Saldo anda")
        
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCRedeem")
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCTopUpList")
        
        bgImg.image = UIImage(named: "bg")
        
        refresh.delegate = self
        refresh.addRefresh(tableView: tableView)
        
        getApi()
    }
    
    func getApi(){
        model.getData { (data, err) in
            self.refresh.stopAnimation()
            if err == nil{
                self.arrRedeem = data
                self.tableView.reloadData()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func submit(no: String, bank: String, jml: String){
        let api = ADRDSubmit()
        api.setParam(no: no, bank: bank, jml: jml)
        api.submit { (msg, err) in
            if err == nil{
                let alert = BKDNAlert.showAlertErr(title: "Success", msg: msg)
                self.present(alert, animated: true, completion: nil)
                self.getSaldo()
                self.actionRefresh()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func getSaldo(){
        let apiMySaldo    = ADMySaldo()
        apiMySaldo.getData { (data, err) in
            if err == nil{
            }
            else{
                
            }
        }
    }
}

extension VCRedeem: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return arrRedeem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCRedeem") as? TVCRedeem
            cell?.configHeader()
            cell?.delegate = self
            return cell ?? UITableViewCell()
        default:
            let data = arrRedeem[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCTopUpList") as? TVCTopUpList
            cell?.setDataReeem(data: data)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 333
        default:
            return 138
        }
    }
}

extension VCRedeem: BKDNRefreshControlDelegate{
    func actionRefresh() {
        getApi()
    }
}

extension VCRedeem: TVCRedeemDelegate{
    func redeemSubmit(bank: String, no: String, jml: String) {
        if validate(bank: bank, no: no, jml: jml){
            self.submit(no: no, bank: bank, jml: jml)
        }
    }
    
    func validate(bank: String, no: String, jml: String) -> Bool{
        var msg = ""
        
        if bank.count <= 0{
            msg = "Silahkan pilih bank anda"
        }
        else if no.count <= 0{
            msg = "No Rekening Anda tidak boleh kosong"
        }
        else if no.count < 8{
            msg = "No Rekening minimal 8 digit"
        }
        else if jml.count <= 0{
            msg = "Jumlah tidak boleh kosong"
        }
        else{
            return true
        }
        
        let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
        self.present(alert, animated: true, completion: nil)
        return false
    }
}
