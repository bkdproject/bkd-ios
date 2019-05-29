//
//  VCTransaksiDetail.swift
//  bukadana
//
//  Created by Gaenael on 3/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCTransaksiDetail: UIViewController {
    
    var model   = ADTD()
    
    @IBOutlet weak var vwHeader: BKDNVHeader!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgImg: UIImageView!
    
    var refresh = BKDNRefreshControl()
    var data    = Dictionary<String, Any>()
    
    //>>
    var detail_angsuran : [Dictionary<String, Any>]? = []
    var repayment_list  : [Dictionary<String, Any>]? = []
    var transaksi       : Dictionary<String, Any>?   = nil
    var log_pinjaman    : Dictionary<String, Any>?   = nil
    var jatuhtempo      : String? = nil
    var status_transaksi      : String? = nil
    var nominal_jml_angsuran  : Int = 0
    var tenors          : String? = nil
    var currindex = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()
    }

    func config(){
        tableView.contentInset    = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.separatorStyle  = .none
        tableView.backgroundColor = .groupTableViewBackground
        vwHeader.setStyle3(title: "Detail Transaksi", desc: "Detail Transaksi Anda")
        vwHeader.button1.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        BKDNView.registerNibTableView(tblView: tableView, nibName: getNibDetail())
        BKDNView.registerNibTableView(tblView: tableView, nibName: getNibHeaderRiwayat())
        BKDNView.registerNibTableView(tblView: tableView, nibName: getNibRiwayatContent())
        BKDNView.registerNibTableView(tblView: tableView, nibName: getNibRiwayatButton())
        
        bgImg.image = UIImage(named: "bg")
        
        refresh.delegate = self
        refresh.addRefresh(tableView: tableView)
        
        self.getApi()
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getNibDetail()         -> String {return "TVCTD"}
    private func getNibHeaderRiwayat()  -> String {return "TVCTDRiwayat"}
    private func getNibRiwayatContent() -> String {return "TVCTDRiwayatContent"}
    private func getNibRiwayatButton() -> String {return "TVCTDRiwayatButton"}
    
    
    private func getCellDetail(tblView: UITableView, index: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCTD") as? TVCTD
        cell?.setData(right: self.getMenuRight(data: data), left: self.getMenuLeft(data: data))
        return cell ?? UITableViewCell()
    }
    
    private func getHeader(tblView: UITableView, index: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCTD") as? TVCTD
        cell?.setData(right: self.getMenuRight(data: data), left: self.getMenuLeft(data: data))
        return cell ?? UITableViewCell()
    }
    
    private func getRiwayatHeader(tblView: UITableView) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: getNibHeaderRiwayat()) as? TVCTDRiwayat
        return cell ?? UITableViewCell()
    }
    
    private func getRiwayat(tblView: UITableView, index: IndexPath) -> UITableViewCell{
        let data = repayment_list?[index.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: getNibRiwayatContent()) as? TVCTDRiwayat
        cell?.delegat = self
        cell?.currindex = index
        cell?.setupContent(datas: data)
        cell?.setRight(r: getRiwayat(data: data, index: index.row))
        cell?.vwSepTop.isHidden = (index.row == 0)
        
        return cell ?? UITableViewCell()
    }
    
    private func getRiwayatButton(tblView: UITableView) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: getNibRiwayatButton()) as? TVCTDRiwayat
        cell?.setBTN()
        cell?.delegat = self
        return cell ?? UITableViewCell()
    }
    
    func getApi(){
        model.no = data["transaksi_id"] as? String ?? ""
        model.getData { (datas, err) in
            self.refresh.stopAnimation()
            if err == nil{
                self.repayment_list = datas["repayment_list"] as? [Dictionary<String, Any>]
                self.transaksi = datas["transaksi"] as? Dictionary<String, Any>
                self.log_pinjaman = datas["log_pinjaman"] as? Dictionary<String, Any>
                self.jatuhtempo = datas ["jatuh_tempo"] as? String
                self.status_transaksi     = datas ["status_transaksi"] as? String
                self.nominal_jml_angsuran = datas ["nominal_jml_angsuran"] as? Int ?? 0
                self.tenors = datas ["tenor_label"] as? String ?? ""
                if self.nominal_jml_angsuran == 0{
                    self.nominal_jml_angsuran = Int(datas ["nominal_jml_angsuran"] as? String ?? "0") ?? 0
                }
                self.tableView.reloadData()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension VCTransaksiDetail: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if jatuhtempo != nil{
                return 1
            }
            else{
                return 0
            }
        default:
            return self.repayment_list?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return getCellDetail(tblView:tableView, index:indexPath)
        default:
            return getRiwayat(tblView:tableView, index:indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return 88
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            if (self.repayment_list?.count ?? 0) == 0{
                return nil
            }
            else{
                return getRiwayatHeader(tblView: tableView)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            if (self.repayment_list?.count  ?? 0) == 0{
                return 0
            }
            else{
                return 72
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            if status_transaksi != "Menunggu Pembayaran"{
                return nil
            }
            else{
                return getRiwayatButton(tblView: tableView)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            if status_transaksi != "Menunggu Pembayaran"{
                return 0
            }
            else{
                return 66
            }
        }
    }
}

extension VCTransaksiDetail: BKDNRefreshControlDelegate{
    func actionRefresh() {
        self.getApi()
    }
    
    func getMenuRight(data: Dictionary<String,Any>) -> [[String]]{
        let dana = transaksi?["Jml_permohonan_pinjaman_disetujui"] as? String ?? ""
        
        let no     = data["transaksi_id"] as? String  ?? ""
        let nama   = data["type_business_name"] as? String ?? ""
        let tenor  = self.tenors ?? ""
        let status = data["transaksi_status"] as? String ?? ""
        let jml    = "Rp " + (BKDNCurrency.formatCurrency(UInt32(dana) ?? 0))
        
        return [
            ["NO\n",                   no],
            ["\n\nNama Transaksi\n",   nama],
            ["\n\nTenor\n"           , tenor.replacingOccurrences(of: "Hari", with: "Bulan")],
            ["\n\nJumlah Pendanaan\n", jml],
            ["\n\nStatus\n"          , status]
        ]
    }
    
    func getMenuLeft(data: Dictionary<String,Any>) -> [[String]]{
        let no     = data["type_business_name"] as? String  ?? ""
        let jml    = "Rp " + (data["totalrp"] as? String ?? "0")
        let jt     = jatuhtempo ?? "-"
        let name   = transaksi?["nama_peminjam"] as? String ?? ""
        
        return [
            ["Jenis\n",             no],
            ["\n\nNama Peminjam\n"    , name],
            ["\n\nJatuh Tempo\n"      , jt],
            ["\n\nJumlah Pinjaman\n " , jml]
        ]
    }
    
    func getRiwayat(data: Dictionary<String,Any>?, index: Int) -> [[String]]{
        let no     = "\(index+1)"
        var price  = data?["nominal_cicilan"] as? String  ?? "0"
        price      = BKDNCurrency.formatCurrency(UInt32(price) ?? 0)
        let status = data?["status"] as? String  ?? ""
        
        return [
            ["Angsuran Ke " , no],
            ["\nRp "        , price],
            ["\nStatus : "  , status]
        ]
    }
}

extension VCTransaksiDetail: TVCTDRiwayatDelegate{
    func bayar(index: IndexPath) {
        self.currindex = index
        toCheckPass()
    }
    
    func toCheckPass(){
        let saldo            = BKDNUserSaldoModel.getData().saldo
        if saldo >= nominal_jml_angsuran{
            let v = VCheckPass.init(nibName: "VCheckPass", bundle: nil)
            v.delegate = self
            v.modalPresentationStyle = .overCurrentContext
            self.present(v, animated: true, completion: nil)
        }
        else{
            let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Saldo kamu tidak cukup untuk melakukan pembayaran")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func toDetailView(){
//        let data = repayment_list?[currindex.row]
        let v = VCDetailPembayaran.init(nibName: "VCDetailPembayaran", bundle: nil)
        v.delegat = self
        v.isDana  = false
        v.noTransaksi   = self.transaksi?["transaksi_id"] as? String ?? ""
        v.jmlPembayaran = nominal_jml_angsuran
        v.modalPresentationStyle = .overCurrentContext
        self.present(v, animated: true, completion: nil)
    }
}

extension VCTransaksiDetail: VCheckPassDelegate{
    func success() {
        toDetailView()
    }
}

extension VCTransaksiDetail: VCDetailPembayaranDelegate{
    func completed() {
        self.navigationController?.popViewController(animated: true)
    }
}


/*
 "transaksi_status": Proses Review,
 "totalrp": 1,000,000,
 "total_approve": 0,
 "tgl_approve": 0000-00-00 00:00:00,
 "id_mod_type_business": 1,
 "transaksi_id": PK-APP2177747BA7A3C78,
 "type_business_name": Pinjaman Kilat,
 "Loan_term": 7,
 "tgl_transaksi": 2019-02-12 11:54:29,
 "product_title": Pinjaman Kilat 7 Hari,
 "date_close": 0000-00-00 00:00:00
 */
