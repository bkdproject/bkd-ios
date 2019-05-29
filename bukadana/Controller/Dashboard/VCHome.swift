//
//  VCHome.swift
//  bukadana
//
//  Created by Gaenael on 1/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCHome: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    let apiMyData     = ADMyData()
    let apiMySaldo    = ADMySaldo()
    let apiDTransaksi = ADDataTransaksi()
    
    var arrRepayment  = [Dictionary<String,Any>]()
    
    var index = 0
    
    var loading = VHandle()
    var refresh = BKDNRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tblView.reloadData()
        self.actionRefresh()
    }

    func configUI(){
        loading.loadViewFromNib(nib: .loading)
        loading.frame = CGRect(x: 0, y: 0, width: BKDNFrame.getWidht(), height: BKDNFrame.getHeight())
        loading.setupLoading()
        self.view.addSubview(loading)
        
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCHomeHeader")
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCFeatures")
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCHomeSaldo")
        
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCRepaymentHeader")
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCRepaymentBody")
        
        self.tblView.delegate       = self
        self.tblView.dataSource     = self
        self.tblView.separatorStyle = .none
        
        self.actionRefresh()
        
        refresh.delegate = self
        refresh.addRefresh(tableView: tblView)
    }
    
    func checkUserPersentase() -> Bool{
        let userdata  = BKDNUserDataModel.getData()
        let strProg  = userdata.peringkat_pengguna_persentase
        return strProg == "100"
    }
    
    func checkPinjaman(){
        let api = ADCheckPinjaman()
        api.getData { (data, err) in
            if err == nil{
                if let active = data["active"] as? Bool{
                    if active{
//                        self.toCheckPass()
                        self.success()
                    }
                    else{
                        if let msg = data["message"] as? String{
                            let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else{
                            let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Silahkan coba beberapa saat lagi")
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                else{
                    let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Silahkan coba beberapa saat lagi")
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func toCheckPass(){
        let v = VCheckPass.init(nibName: "VCheckPass", bundle: nil)
        v.delegate = self
        v.modalPresentationStyle = .overCurrentContext
        self.present(v, animated: true, completion: nil)
    }
}

extension VCHome: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            if arrRepayment.count > 2{
                return 2
            }
            else{
                return arrRepayment.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TVCHomeHeader") as? TVCHome
                cell?.setupProfile()
                return cell!
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TVCFeatures") as? TVCFeatures
                cell?.delegate = self
                return cell!
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TVCHomeSaldo") as? TVCHome
                cell?.setupSaldo()
                return cell!
            }
        default:
            let data = arrRepayment[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCRepaymentBody") as? TVCRepayment
            cell?.setData(data: data)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    return 72
                case 1:
                    return 208
                default:
                    return 82
                }
            default :
                return 46
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            let header = tableView.dequeueReusableCell(withIdentifier: "TVCRepaymentHeader") as? TVCRepayment
            return header!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 30
        }
    }
    
    func clearImage(){
        UIImageView.af_sharedImageDownloader.imageCache?.removeAllImages()
        UIImageView.af_sharedImageDownloader.sessionManager.session.configuration.urlCache?.removeAllCachedResponses()
    }
}

extension VCHome{
    func getData(){
        apiMyData.getData { (data, err) in
            BKDNLog.log(str: "\(data)", types: .other)
            self.clearImage()
            self.tblView.reloadData()
        }
    }
    
    func getSaldo(){
        apiMySaldo.getData { (data, err) in
            if err == nil{
                self.tblView.reloadData()
            }
            else{
                
            }
        }
    }
    
    func getRepayment(){
        apiDTransaksi.getData { (data, err) in
            if err == nil{
                self.arrRepayment = data
                self.tblView.reloadData()
                self.refresh.stopAnimation()
            }
            else{
                
            }
        }
    }
    
    func cekBiayai(){
        let api = ADCheckBiaya()
        api.getData { (data, err) in
            if err == nil{
                let res = data["response"] as? String
                let st  = (res != "fail")
                BKDNUserDataModel.updateCekBiaya(status: st)
            }
            else{
            }
        }
    }
}

extension VCHome: TVCFeaturesDelegate{
    func features(Index: Int) {
        let type = typeUser.init(rawValue: BUserKeyModel.getType()) ?? .peminjam
        switch type {
        case .peminjam:
            if checkUserPersentase(){
                self.index = Index
                self.checkPinjaman()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Silahkan lengkapi profile anda terlebih dahulu")
                self.present(alert, animated: true, completion: nil)
            }
        default:
            let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Feature ini hanya untuk akun peminjam")
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension VCHome: VCheckPassDelegate{
    func success() {
        switch self.index {
        case 0:
            self.performSegue(withIdentifier: "toBKDanaKilat", sender: nil)
        default:
            self.performSegue(withIdentifier: "toBKDanaMikro", sender: nil)
        }
    }
}

extension VCHome: BKDNRefreshControlDelegate{
    func actionRefresh() {
        self.getData()
        self.getSaldo()
        self.getRepayment()
        
//        let type = typeUser.init(rawValue: BUserKeyModel.getType()) ?? .peminjam
//        if type == .pendana{
//            self.cekBiayai()
//        }
    }
}
