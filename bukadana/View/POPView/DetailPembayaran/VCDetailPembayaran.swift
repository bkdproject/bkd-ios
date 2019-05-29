//
//  VCDetailPembayaran.swift
//  bukadana
//
//  Created by Gaenael on 3/4/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol VCDetailPembayaranDelegate {
    func completed()
}

class VCDetailPembayaran: UIViewController {
    
    var delegat: VCDetailPembayaranDelegate?
    var apiDana   = ADTPendanaanSubmit()
    var apiPinjam = ADTPinjamanSubmit()
    
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var vwTxt: UIView!
    @IBOutlet weak var txtTotal: UITextField!
    @IBOutlet weak var lblNote: UILabel!
    
    @IBOutlet weak var lblSaldo: UILabel!
    @IBOutlet weak var lblPembayaranP: UILabel!
    @IBOutlet weak var lblTitleTagihan: UILabel!
    
    var jmlPembayaran = 0
    var noTransaksi   = ""
    var isDana        = false
    
    var loading = VHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        BKDNView.radius(vw: [vwContent, btnSubmit, vwTxt], rad: 8)
        BKDNView.border(vw: vwTxt)
        
        lblNote.attributedText = BString.setAtrNotePembayaran()
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(dismisss))
        vwBg.addGestureRecognizer(tap)
        
        let saldo            = BKDNUserSaldoModel.getData().saldo
        lblSaldo.text        = "\(BKDNCurrency.formatCurrency(UInt32(saldo))) IDR"
        lblPembayaranP.text  = "\(BKDNCurrency.formatCurrency(UInt32(jmlPembayaran))) IDR"
        
        if !isDana{
            lblTitleTagihan.text = "Tagihan :"
            
            let saldo            = BKDNUserSaldoModel.getData().saldo
            if saldo > jmlPembayaran{
                txtTotal.text = "\(jmlPembayaran)"
                txtTotal.isUserInteractionEnabled = false
            }
        }
        else{
            lblTitleTagihan.text = "Dibutuhkan :"
        }
        
        loading.loadViewFromNib(nib: .loading)
        loading.frame = CGRect(x: 0, y: 0, width: BKDNFrame.getWidht(), height: BKDNFrame.getHeight())
        loading.setupLoading()
        self.view.addSubview(loading)
    }
    
    @objc func dismisss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if isDana{
            self.txtTotal.becomeFirstResponder()
        }
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        self.postApi()
    }
    
    func postApi(){
        if isDana{
            if validatePendana(){
                postDana()
            }
        }
        else{
            if validatePeminjam(){
                postPinjam()
            }
        }
    }
    
    func postDana(){
        loading.startLoading()
        let api = ADTPendanaanSubmit()
        api.setParam(no: noTransaksi, jml: txtTotal.text ?? "0")
        api.submit { (st, err) in
            self.loading.stopLoading()
            if err == nil{
                self.getSaldo()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func postPinjam(){
        loading.startLoading()
        let api = ADTPinjamanSubmit()
        api.setParam(no: noTransaksi, jml: txtTotal.text ?? "0")
        api.submit { (st, err) in
            self.loading.stopLoading()
            if err == nil{
                self.getSaldo()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func validatePeminjam() -> Bool{
        if let tot = txtTotal.text{
            if let sld = Int(tot){
                let saldo           = BKDNUserSaldoModel.getData().saldo
                
                if sld < jmlPembayaran{
                    let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Jumlah pembayaran kurang dari tagihan")
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
                else if sld > saldo{
                    let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Saldo anda tidak mencukupi")
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
                else{
                    return true
                }
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Silahkan input jumlah tagihan")
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        else{
            let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Silahkan input jumlah tagihan")
            self.present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    func validatePendana() -> Bool{
        if let tot = txtTotal.text{
            if let sld = Int(tot){
                let saldo           = BKDNUserSaldoModel.getData().saldo
                
                if sld < 100000{
                    let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Dana minimal Rp 100,000")
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
                else if sld > saldo{
                    let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Saldo anda tidak mencukupi")
                    self.present(alert, animated: true, completion: nil)
                    return false
                }
                else{
                    return true
                }
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Silahkan input jumlah tagihan")
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        else{
            let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Silahkan input jumlah tagihan")
            self.present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    func getSaldo(){
        let apiMySaldo    = ADMySaldo()
        apiMySaldo.getData { (data, err) in
            var msg = ""
            if self.isDana{
                msg = "Pendanaan Berhasil"
            }
            else{
                msg = "Pembayaran berhasil"
            }
            let alert = BKDNAlert.showAlertSuccess(title: "Sukses", msg: msg, action: { (_) in
                self.dismiss(animated: true, completion: {
                    self.delegat?.completed()
                })
            })
            self.present(alert, animated: true, completion: nil)
        }
    }
}
