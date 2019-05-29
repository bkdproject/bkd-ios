//
//  VCInformasiPribadiKilat.swift
//  bukadana
//
//  Created by Gaenael on 1/20/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCInformasiPribadiKilat: UIViewController {

    @IBOutlet weak var vwHeader: BKDNVHeader!
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    var arrMenu = [MFormText]()
    
    var loading = VHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for n in getNIB() {
            BKDNView.registerNibTableView(tblView: tableView, nibName: n)
        }
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        bgImage.image = UIImage(named: "bg")
        
        vwHeader.setStyleForm(title: "Daftar BKDana Kilat", desc: "Beberapa langkah lagi untuk menjadi peminjam di BKDana. Silahkan lengkapi informasi dan data-data Anda terlebih dahulu.")
        vwHeader.button1.addTarget(self, action: #selector(actionButton1), for: .touchUpInside)
        
        loading.loadViewFromNib(nib: .loading)
        loading.frame = CGRect(x: 0, y: 0, width: BKDNFrame.getWidht(), height: BKDNFrame.getHeight())
        loading.setupLoading()
        self.view.addSubview(loading)
        
        arrMenu = getMenu()
    }
    
    private func getNIB() -> [String]{
        return [
            getNib(),
            getNibTitle(),
            getNibButton(),
        ]
    }
    
    private func getNib()       -> String{ return  "TVCFormText" }
    private func getNibTitle()  -> String{ return  "TVCTitle" }
    private func getNibButton() -> String{ return "TVCButtonNext" }
    
    private func nextSegue()    -> String{ return "toUploadPribadiKilat" }
    
    private func getTitle() -> MFormTitle{
        return MFormTitle.init(title: "Deskripsi Pribadi", desc: "Silahkan masukan data diri Anda sebenar - benarnya.")
    }
    private func getMenu() -> [MFormText]{
        let data = BKDNUserDataModel.getData()
        return [
            MFormText.init(title: "* Nama Pendidikan",             placeholder: "-- Pilih --", content: data.Pendidikan,  style: .dropdown),
            MFormText.init(title: "* Nama Perusahaan",             placeholder: "Nama Perusahaan", content: data.nama_perusahaan, style: .text),
            MFormText.init(title: "* Telepon Tempat Bekerja",       placeholder: "Telepon Tempat Bekerja", content: data.no_telp_perusahaan, style: .text),
            MFormText.init(title: "* Status Karyawan",             placeholder: "-- Pilih --", content: data.status_karyawan,  style: .dropdown),
            MFormText.init(title: "* Lama Bekerja",                placeholder: "Lama Bekerja", content: data.lama_bekerja,  style: .text),
            MFormText.init(title: "* Nama Atasan Langsung",        placeholder: "Nama Atasan Langsung", content: data.nama_atasan, style: .text),
            MFormText.init(title: "* Nama Referensi Teman / Saudara 1", placeholder: "Nama Referensi Teman / Saudara 1", content: data.referensi_nama_1,  style: .text),
            MFormText.init(title: "* No HP Referensi Teman / Saudara 1", placeholder: "No HP Referensi Teman / Saudara 1", content: data.referensi_1,  style: .text),
            MFormText.init(title: "* Nama Referensi Teman / Saudara 2", placeholder: "Nama Referensi Teman / Saudara 2", content: data.referensi_nama_2, style: .text),
            MFormText.init(title: "* No HP Teman / Saudara 2",  placeholder: "No HP Referensi Teman / Saudara 2", content: data.referensi_2, style: .text)
        ]
    }
    
}


extension VCInformasiPribadiKilat: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return arrMenu.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: getNibTitle()) as? TVCTitle
            cell?.setTitle(title: getTitle())
            return cell!
        default:
            switch indexPath.row{
            case arrMenu.count:
                let cell = tableView.dequeueReusableCell(withIdentifier: getNibButton()) as? TVCButton
                cell?.configFormNext()
                cell?.delegate = self
                return cell!
            default:
                let menu = arrMenu[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: getNib()) as? TVCFormText
                cell?.styleText(form: menu)
                cell?.index = indexPath
                cell?.delegate = self
                switch menu.title{
                case "* Nama Pendidikan":
                    cell?.txtField.configPicker()
                    cell?.txtField.setArr(data: BKDNDataArray.getListPendidikan())
                case "* Status Karyawan":
                    cell?.txtField.configPicker()
                    cell?.txtField.setArr(data: BKDNDataArray.getListStatusKaryawan())
                case "* Telpon Tempat Bekerja":
                    cell?.txtField.configText()
                    cell?.txtField.keyboardType = .numberPad
                case "* Lama Bekerja":
                    cell?.txtField.configText()
                    cell?.txtField.keyboardType = .numberPad
                case "* No HP Referensi Teman / Saudara 1":
                    cell?.txtField.configText()
                    cell?.txtField.keyboardType = .numberPad
                case "* No HP Referensi Teman / Saudara 2":
                    cell?.txtField.configText()
                    cell?.txtField.keyboardType = .numberPad
                default:
                    cell?.txtField.configText()
                }
                return cell!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        default:
            switch indexPath.row{
            case arrMenu.count:
                return 58
            default:
                return 70
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension VCInformasiPribadiKilat: TVCButtonDelegate{
    @objc func actionButton1() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionButton2() {
        if validate(){
            loading.startLoading()
            
            let api = ADMSubmitKilat2()
            api.setParam(model: self.arrMenu)
            api.submit { (st, err) in
                self.loading.stopLoading()
                
                if err == nil{
                    self.performSegue(withIdentifier: self.nextSegue(), sender: nil)
                }
                else{
                    let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension VCInformasiPribadiKilat: TVCFormTextDelegate{
    func changeText(str: String, ind: IndexPath) {
        let menu = arrMenu[ind.row]
        menu.setContent(con: str)
        arrMenu[ind.row] = menu
    }
    
    func validate() -> Bool{
        var msg = ""
        
        if arrMenu[0].content.count <= 0{
            msg = "Nama Pendidikan tidak boleh kosong"
        }
        else if arrMenu[1].content.count <= 0{
            msg = "Nama Perusahaan tidak boleh kosong"
        }
        else if arrMenu[2].content.count <= 0{
            msg = "Telepon Tempat Bekerja tidak boleh kosong"
        }
        else if arrMenu[3].content.count <= 0{
            msg = "Status Karyawan boleh kosong"
        }
        else if arrMenu[4].content.count <= 0{
            msg = "Lama Bekerja boleh kosong"
        }
        else if arrMenu[5].content.count <= 0{
            msg = "Nama Atasan Langsung tidak boleh kosong"
        }
        else if arrMenu[6].content.count <= 0{
            msg = "Nama Referensi Teman / Saudara 1 tidak boleh kosong"
        }
        else if arrMenu[7].content.count <= 0{
            msg = "No HP Referensi Teman / Saudara 1 tidak boleh kosong"
        }
        else if arrMenu[8].content.count <= 0{
            msg = "Nama Referensi Teman / Saudara 2 tidak boleh kosong"
        }
        else if arrMenu[9].content.count <= 0{
            msg = "No HP Referensi Teman / Saudara 1 tidak boleh kosong"
        }
        else{
            return true
        }
        
        let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
        self.present(alert, animated: true, completion: nil)
        return false
    }
}
