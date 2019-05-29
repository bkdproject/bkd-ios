//
//  VCDaftarPeminjam.swift
//  bukadana
//
//  Created by Gaenael on 2/25/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCDaftarPeminjam: UIViewController {

    var model   = ADMListPeminjam()
    var refresh = BKDNRefreshControl()
    
    @IBOutlet weak var vwHeader: BKDNVHeader!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var vwSearch: UIView!
    
    var arrTransaksi = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = segue.identifier
        if iden == "toDetail"{
            let data = sender as? Dictionary<String,Any>
            let vc = segue.destination as? VCDetailDaftarPeminjam
            vc?.transaksiNo = data!["transaksi_id"] as? String ?? ""
        }
    }
    
    func config(){
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCListPeminjam")
    
        vwHeader.setStyle3(title: "Daftar Peminjam", desc: "Daftar Peminjam Yang Sedang Aktif")
        vwHeader.button1.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        bgImg.image = UIImage(named: "bg")

        var frames        = vwSearch.frame
        frames.origin.y   = 0
        frames.origin.x   = 0
        frames.size.width = BKDNFrame.getWidht() - (16 * 2)
        BKDNView.setShadow3(vw: vwSearch, bounds: frames)

        refresh.delegate = self
        refresh.addRefresh(tableView: tableView)

        getApi()
    }
    
    func getApi(){
        model.getData { (data, err) in
            self.refresh.stopAnimation()
            if err == nil{
                self.arrTransaksi = data
                self.tableView.reloadData()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func dismiss(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

extension VCDaftarPeminjam: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTransaksi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrTransaksi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCListPeminjam") as? TVCListPeminjam
        cell?.setData(data: data)
        cell?.delegate = self
        cell?.index    = indexPath
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 268
    }
}

extension VCDaftarPeminjam: BKDNRefreshControlDelegate{
    func actionRefresh() {
        getApi()
    }
}

extension VCDaftarPeminjam: TVCListPeminjamDelegate{
    func actionDetail(row: Int) {
        let data = arrTransaksi[row]
        self.performSegue(withIdentifier: "toDetail", sender: data)
    }
}
