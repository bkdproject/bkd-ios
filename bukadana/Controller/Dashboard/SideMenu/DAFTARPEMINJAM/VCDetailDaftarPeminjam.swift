//
//  VCDetailDaftarPeminjam.swift
//  bukadana
//
//  Created by Gaenael on 3/4/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCDetailDaftarPeminjam: UIViewController {

    var model   = ADMDetailPeminjam()
    var refresh = BKDNRefreshControl()
    
    @IBOutlet weak var vwHeader: BKDNVHeader!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgImg: UIImageView!
    
    var transaksiNo = ""
    
    var data: Dictionary<String,Any>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()
    }
    
    func config(){
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.separatorStyle  = .none
        tableView.backgroundColor = .groupTableViewBackground
        BKDNView.registerNibTableView(tblView: tableView, nibName: getNib())
        
        vwHeader.setStyle3(title: "Detail Peminjaman", desc: "Detail Peminjam   Sedang Aktif")
        vwHeader.button1.addTarget(self, action: #selector(dismisss), for: .touchUpInside)
        bgImg.image = UIImage(named: "bg")
        
        refresh.delegate = self
        refresh.addRefresh(tableView: tableView)

        getApi()
    }
    
    @objc func dismisss(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getNib()        -> String{ return "TVCDetailPeminjam" }
}

extension VCDetailDaftarPeminjam: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.data != nil{
            return 1
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: getNib()) as? TVCDetailPeminjam
        cell?.setData(data: self.data!)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 403
    }
}

extension VCDetailDaftarPeminjam: BKDNRefreshControlDelegate{
    func actionRefresh() {
        getApi()
    }
    
    func getApi(){
        model.no = self.transaksiNo
        model.getData { (data, err) in
            self.refresh.stopAnimation()
            if err == nil{
                self.data = data
                self.tableView.reloadData()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension VCDetailDaftarPeminjam: TVCDetailPeminjamDelegate{
    func actionBiayai() {
        toCheckPass()
    }
    
    func toCheckPass(){
        let v = VCheckPass.init(nibName: "VCheckPass", bundle: nil)
        v.delegate = self
        v.modalPresentationStyle = .overCurrentContext
        self.present(v, animated: true, completion: nil)
    }
    
    func toDetailView(){
        let dana   = Int(self.data?["total_pendanaan"] as? String ?? "0") ?? 0
        let pinjam = Int(self.data?["total_pinjaman"] as? String ?? "0") ?? 0
        let ak     = pinjam - dana
        let v = VCDetailPembayaran.init(nibName: "VCDetailPembayaran", bundle: nil)
        v.delegat = self
        v.isDana  = true
        v.noTransaksi = self.data?["no_transaksi_pinjaman"] as? String ?? ""
        v.jmlPembayaran = ak
        v.modalPresentationStyle = .overCurrentContext
        self.present(v, animated: true, completion: nil)
    }
}

extension VCDetailDaftarPeminjam: VCheckPassDelegate{
    func success() {
        toDetailView()
    }
}

extension VCDetailDaftarPeminjam: VCDetailPembayaranDelegate{
    func completed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
