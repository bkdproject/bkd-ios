//
//  VCTopup.swift
//  bukadana
//
//  Created by Gaenael on 2/15/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCTopup: UIViewController {
    
    var model   = ADTUList()
    var refresh = BKDNRefreshControl()
    var arrTopup = [Dictionary<String, Any>]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var vwHeader: BKDNVHeader!
    
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
        vwHeader.setStyle4(title: "Top Up", desc: "Kanal Pembayaran")
        bgImg.image = UIImage(named: "bg")
        
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCTopUp")
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCTopUpTitle")
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCTopUpList")
        
        refresh.delegate = self
        refresh.addRefresh(tableView: tableView)
        
        getApi()
    }
    
    func getApi(){
        model.getData { (data, err) in
            self.refresh.stopAnimation()
            if err == nil{
                self.arrTopup = data
                self.tableView.reloadData()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension VCTopup: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return arrTopup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row{
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TVCTopUp", for: indexPath) as? TVCTopUp
                    cell?.configHeader()
                    return cell ?? UITableViewCell()
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TVCTopUpTitle") as? TVCTopUp
                    return cell ?? UITableViewCell()
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCTopUpList") as? TVCTopUpList
            cell?.setData(data: arrTopup[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row{
            case 0:
                return 103
            default:
                return 35
            }
        default:
            return 138
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row{
                case 0:
                    setPopupTopup()
                default:
                    break
            }
        default:
            break
        }
    }
    
}

extension VCTopup: VCPOPTopupDelegate, VCPopWebviewDelegate{
    func submitPostApi(msg: String) {
        self.setWebview(url: msg)
    }
    
    func success() {
        let alert = BKDNAlert.showAlertSuccess(title: "Info", msg: "Status transaksi anda pending, segera lakukan pembayaran di ATM. Cek email anda segera") { (_) in
            self.getApi()
            self.getSaldo()
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension VCTopup: BKDNRefreshControlDelegate{
    func actionRefresh() {
        getApi()
    }
    
    func setPopupTopup(){
        let vc      = VCPOPTopup.init(nibName: "VCPOPTopup", bundle: nil)
        vc.delegate = self
        vc.view.backgroundColor   = UIColor.black.withAlphaComponent(0.5)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    func setWebview(url: String){
        let vc      = VCPopWebview.init(nibName: "VCPopWebview", bundle: nil)
        vc.delegate = self
        vc.url      = url
        self.present(vc, animated: true, completion: nil)
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
