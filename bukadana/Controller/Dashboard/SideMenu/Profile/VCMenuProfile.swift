//
//  VCMenuProfile.swift
//  bukadana
//
//  Created by Gaenael on 1/29/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCMenuProfile: UIViewController {
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var vwHeader: BKDNVHeader!
    
    @IBOutlet weak var tblView: UITableView!
    
    var arrProfile = [MFormProfile]()
    var arrAddress = [MFormProfile]()
    
    var currIndex  = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    func configUI(){
        arrProfile = getArrProfile()
        arrAddress = getArrAddree()
        
        bgImg.image = UIImage(named: "bg")
        
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCMenuProfileInformasiAkun")
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCMenuProfileUbahPassword")
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCMenuProfileInformasiAlamat")
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCProfileTitle")
        BKDNView.registerNibTableView(tblView: self.tblView, nibName: "TVCButtonLogout")
        
        self.tblView.delegate        = self
        self.tblView.dataSource      = self
        self.tblView.separatorStyle  = .none
        self.tblView.backgroundColor = .groupTableViewBackground
        vwHeader.setProfileForm(title: "Ubah Profil", desc: "Isi Profile anda dengan identitas anda.")
        vwHeader.button1.addTarget(self, action: #selector(dismisss), for: .touchUpInside)
    }
    
    @objc func dismisss(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension VCMenuProfile: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == currIndex{
            if row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TVCMenuProfileInformasiAkun") as? TVCMenuProfile
                cell?.setInformasiAkun(data: arrProfile)
                cell?.delegate = self
                return cell!
            }
            else if row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TVCMenuProfileUbahPassword") as? TVCMenuProfile
                cell?.setUbahPassword()
                cell?.delegate = self
                return cell!
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier:
                    "TVCMenuProfileInformasiAlamat") as? TVCMenuProfile
                cell?.setInformasiAlamat(data: arrAddress)
                cell?.delegate = self
                return cell!
            }
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCProfileTitle") as? TVCMenuProfile
            cell?.setDefault(row: row)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        if row == currIndex{
            if row == 0{
                return 883
            }
            else if row == 1{
                return 356
            }
            else{
                return 543
            }
        }
        else{
            return 79
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currIndex != indexPath.row{
            currIndex = indexPath.row
            let indexSet = IndexSet(integer: indexPath.section)
            tableView.reloadSections(indexSet, with: .none)
        }
    }
}

extension VCMenuProfile{
    func getArrProfile() -> [MFormProfile]{
        let user = BKDNUserDataModel.getData()
        var arr = [MFormProfile]()
        arr.append(MFormProfile(title: "Nama",  ph: "Nama", content: user.Nama_pengguna ?? ""))
        arr.append(MFormProfile(title: "NIK",  ph: "NIK", content: user.Nomor_nik ?? ""))
        arr.append(MFormProfile(title: "Jenis Kelamin",  ph: "Jenis Kelamin", content: user.Jenis_kelamin ?? ""))
        arr.append(MFormProfile(title: "Tanggal Lahir",  ph: "Tanggal Lahir", content: user.Tanggal_lahir ?? ""))
        arr.append(MFormProfile(title: "Email", ph: "Email", content: user.email ?? ""))
        arr.append(MFormProfile(title: "Phone", ph: "Phone", content: user.Mobileno ?? ""))
        arr.append(MFormProfile(title: "Bank",  ph: "Pilih Bank", content: user.nama_bank ?? ""))
        arr.append(MFormProfile(title: "Pendidikan",  ph: "Pendidikan", content: user.Pendidikan ?? ""))
        arr.append(MFormProfile(title: "Pekerjaan",  ph: "Pekerjaan", content: user.Pekerjaan ?? ""))
        arr.append(MFormProfile(title: "No Rekening", ph: "No Rekening", content: user.Nomor_rekening ?? ""))
        return arr
    }
    
    func getArrAddree() -> [MFormProfile]{
        let user = BKDNUserDataModel.getData()
        var arr = [MFormProfile]()
        arr.append(MFormProfile(title: "Alamat",   ph: "Alamat", content: user.Alamat ?? ""))
        arr.append(MFormProfile(title: "Kota",     ph: "Kota", content: user.Kota ?? ""))
        arr.append(MFormProfile(title: "Provinsi", ph: "Provinsi", content: user.Provinsi ?? ""))
        arr.append(MFormProfile(title: "Kode POS", ph: "Kode POS", content: user.Kodepos ?? ""))
        return arr
    }
}

extension VCMenuProfile: TVCMenuProfileDelegate{
    func reset() {
        currIndex = -1
        let indexSet = IndexSet(integer: 0)
        tblView.reloadSections(indexSet, with: .none)
    }
    
    func actionUpdate(tag: Int) {
        let cell = getCell(tag: tag)
        switch tag {
        case 0:
            postUpdateAkun(cell: cell)
        case 1:
            postUpdatePassword(cell: cell)
        default:
            postUpdateAlamat(cell: cell)
        }
    }
    
    func postUpdateAkun(cell: TVCMenuProfile){
        let name    = cell.txtField1.textField.text ?? ""
        let nik     = cell.txtField2.textField.text ?? ""
        let gender  = cell.txtField3.textField.text ?? ""
        let ttl     = cell.txtField4.textField.text ?? ""
        let email   = cell.txtField5.textField.text ?? ""
        let telp    = cell.txtField6.textField.text ?? ""
        let nb      = cell.txtField7.textField.text ?? ""
        let pnddkan = cell.txtField8.textField.text ?? ""
        let pkrjaan = cell.txtField9.textField.text ?? ""
        var norek   = cell.txtField10.textField.text ?? ""
        norek = norek.replacingOccurrences(of: " ", with: "")
        
        if validateAkun(name: name, nik: nik, gender: gender, ttl: ttl, email: email, telp: telp, bank: nb, pnd: pnddkan, pkrjaan: pkrjaan, norek: norek){
            let api = ADPUpdateProfile()
            api.setParam(fname: name, Nomor_nik: nik, Jenis_kelamin: gender, Tanggal_lahir: ttl, email: email, telp: telp, pendidikan: pnddkan, pekerjaan: pkrjaan, norek: norek, nb: nb)
            api.getData { (msg, err) in
                if err == nil{
                    self.getData()
                    let alert = BKDNAlert.showAlertSuccess(title: "Success", msg: msg, action: { (_) in
                        self.reset()
                    })
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let alert = BKDNAlert.showAlertErr(title: "Failed", msg: err?.msg ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func postUpdatePassword(cell: TVCMenuProfile){
        let oldPass = cell.txtField1.textField.text ?? ""
        let pass    = cell.txtField2.textField.text ?? ""
        let newPass = cell.txtField3.textField.text ?? ""
        
        if validatePassword(oldPass: oldPass, newPass: pass, confirmPass: newPass){
            let api = ADPUpdatePassword()
            api.setParam(oldPass: oldPass, pass: pass, newPass: newPass)
            api.getData { (msg, err) in
                if err == nil{
                    self.getData()
                    let alert = BKDNAlert.showAlertSuccess(title: "Success", msg: msg, action: { (_) in
                        self.reset()
                    })
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let alert = BKDNAlert.showAlertErr(title: "Failed", msg: err?.msg ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func postUpdateAlamat(cell: TVCMenuProfile){
        let almt = cell.txtView1.textView.text ?? ""
        let kota = cell.txtField1.textField.text ?? ""
        let prov = cell.txtField2.textField.text ?? ""
        let kop  = cell.txtField3.textField.text ?? ""
        
        if validateAlamat(almt: almt, kota: kota, prov: prov, kop: kop){
        let api = ADPUpdateAlamat()
            api.setParam(almt: almt, kota: kota, prov: prov, kodepos: kop)
            api.getData { (msg, err) in
                if err == nil{
                    self.getData()
                    let alert = BKDNAlert.showAlertSuccess(title: "Success", msg: msg, action: { (_) in
                        self.reset()
                    })
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let alert = BKDNAlert.showAlertErr(title: "Failed", msg: err?.msg ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func getCell(tag: Int) -> TVCMenuProfile{
        let cell = self.tblView.cellForRow(at: IndexPath(row: tag, section: 0)) as! TVCMenuProfile
        return cell
    }
    
    func validateAkun(name: String, nik: String, gender: String, ttl: String, email: String, telp: String, bank: String, pnd: String, pkrjaan: String, norek: String) -> Bool{
        var msg = ""
        
        if name.count <= 0{
            msg = "Nama tidak boleh kosong"
        }
        if nik.count <= 0{
            msg = "Nomor NIK tidak boleh kosong"
        }
        if gender.count <= 0{
            msg = "Gender tidak boleh kosong"
        }
        if ttl.count <= 0{
            msg = "ttl tidak boleh kosong"
        }
        if email.count <= 0{
            msg = "Email tidak boleh kosong"
        }
        if telp.count <= 0{
            msg = "Telp tidak boleh kosong"
        }
        if bank.count <= 0{
            msg = "Silahkan pilih bank anda"
        }
        if pnd.count <= 0{
            msg = "Pendidikan tidak boleh kosong"
        }
        if pkrjaan.count <= 0{
            msg = "Pekerjaan tidak boleh kosong"
        }
        if bank.count <= 0{
            msg = "Silahkan pilih bank anda"
        }
        else if norek.count <= 0{
            msg = "No Rekening Anda tidak boleh kosong"
        }
        else if norek.count < 8{
            msg = "No Rekening minimal 8 digit"
        }
        else{
            return true
        }
        
        let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
        self.present(alert, animated: true, completion: nil)
        return false
    }
    
    func validatePassword(oldPass: String, newPass: String, confirmPass: String) -> Bool{
        var msg = ""
        
        if oldPass.count <= 0{
            msg = "Silahkan isi password lama anda"
        }
        if newPass.count <= 0{
            msg = "Silahkan isi password baru anda"
        }
        if confirmPass.count <= 0{
            msg = "Konfirmasi password baru anda anda"
        }
        if newPass != confirmPass{
            msg = "Password baru anda tidak sesuai dengan silahkan cek kembali"
        }
        else{
            return true
        }
        
        let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
        self.present(alert, animated: true, completion: nil)
        return false
    }
    
    func validateAlamat(almt: String, kota: String, prov: String, kop: String) -> Bool{
        var msg = ""
        
        if almt.count <= 0{
            msg = "Telp tidak boleh kosong"
        }
        if kota.count <= 0{
            msg = "Telp tidak boleh kosong"
        }
        if prov.count <= 0{
            msg = "Provinsi tidak boleh kosong"
        }
        if kop.count <= 0{
            msg = "Kode POS tidak boleh kosong"
        }
        else{
            return true
        }
        
        let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
        self.present(alert, animated: true, completion: nil)
        return false
    }
    
    func getData(){
        let apiMyData     = ADMyData()
        apiMyData.getData { (data, err) in
            self.arrProfile = self.getArrProfile()
            self.arrAddress = self.getArrAddree()
            self.reset()
        }
    }
}
