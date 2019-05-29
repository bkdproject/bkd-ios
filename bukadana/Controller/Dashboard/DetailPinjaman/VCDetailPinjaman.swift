//
//  VCDetailPinjaman.swift
//  bukadana
//
//  Created by Gaenael on 1/7/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCDetailPinjaman: UIViewController {

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
        tableView.separatorStyle = .none
        vwHeader.setStyle3(title: "Daftar Peminjam", desc: "Daftar Peminjam yang sedang Aktif")
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCDetailPinjamanPendanaan")
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCDetailPinjaman")
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCDetailInformasiPeminjam")
        
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCButton")
        bgImg.image = UIImage(named: "bg")
    }

}



extension VCDetailPinjaman: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCDetailPinjamanPendanaan") as? TVCDetailPinjaman
            cell?.configPendanaan()
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCDetailPinjaman") as? TVCDetailPinjaman
            cell?.configPinjaman()
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCDetailInformasiPeminjam") as? TVCDetailPinjaman
            cell?.configInformasiPeminjam()
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCButton") as? TVCButton
            cell?.configButtonPinjaman()
            cell?.delegate = self
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 137
        case 1:
            return 156
        case 2:
            return 198
        default:
            return 50
        }
    }
}

extension VCDetailPinjaman: TVCButtonDelegate{
    func actionButton1() {
        
    }
    
    func actionButton2() {
        let vc = VWPOPProsesPembiayaan.init(nibName: "VWPOPProsesPembiayaan", bundle: nil)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle   = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}
