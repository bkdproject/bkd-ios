//
//  VCInformPribadi.swift
//  bukadana
//
//  Created by Gaenael on 1/15/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCInformPribadi: UIViewController {

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
            getNibTV(),
            getNibTitle(),
            getNibButton(),
        ]
    }
    
    private func getNib()        -> String{ return "TVCFormText" }
    private func getNibTV()      -> String{ return "TVCFormTextView" }
    private func getNibTitle()   -> String{ return "TVCTitle" }
    private func getNibButton()  -> String{ return "TVCButtonNext" }
    
    private func nextSegue()  -> String{ return "toInformPribadiKilat" }
    
    private func getTitle() -> MFormTitle{
        return MFormTitle.init(title: "Informasi Pribadi", desc: "Silahkan masukkan data diri anda sebenar - benarnya")
    }
    private func getMenu() -> [MFormText]{
        let data = BKDNUserDataModel.getData()
        return [
            MFormText.init(title: "* Tempat Lahir",  placeholder: "Masukan Tempat lahir", content: data.Tempat_lahir,  style: .text),
            MFormText.init(title: "* Jenis Kelamin", placeholder: "-- Pilih --", content: data.Jenis_kelamin, style: .dropdown),
            MFormText.init(title: "* Tanggal Lahir", placeholder: "MM-dd-yyyy", content: data.Tanggal_lahir, style: .calendar),
            MFormText.init(title: "* Alamat",  placeholder: "Masukan Alamat", content: data.Alamat,  style: .textView),
            MFormText.init(title: "* Kota",  placeholder: "Masukan Kota", content: data.Kota, style: .text),
            MFormText.init(title: "* Provinsi", placeholder: "-- Pilih --", content: data.Provinsi, style: .dropdown),
            MFormText.init(title: "* Kode POS",  placeholder: "Masukan Kode POS",  content: data.Kodepos, style: .text),
            MFormText.init(title: "* Pekerjaan", placeholder: "Masukkan pekerjaan", content: data.Pekerjaan, style: .dropdown),
            MFormText.init(title: "* Nomor NIK",  placeholder: "Masukan Nomor NIK", content: data.Nomor_nik,  style: .text)
        ]
    }
}

extension VCInformPribadi: UITableViewDelegate, UITableViewDataSource{
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: getNibTitle(), for: indexPath) as? TVCTitle
            cell?.setTitle(title: getTitle())
            return cell!
        default:
        switch indexPath.row{
            case arrMenu.count:
                let cell = tableView.dequeueReusableCell(withIdentifier: getNibButton(), for: indexPath) as? TVCButton
                cell?.configFormNext()
                cell?.delegate = self
                return cell!
            default:
                let menu = arrMenu[indexPath.row]
                switch menu.style{
                case .textView:
                    let cell =  tableView.dequeueReusableCell(withIdentifier: getNibTV(), for: indexPath) as? TVCFormText
                        cell?.styleTextView(form: menu)
                        cell?.index = indexPath
                        cell?.delegate = self
                        return cell!
                default:
                    let cell =  tableView.dequeueReusableCell(withIdentifier: getNib(), for: indexPath) as? TVCFormText
                    cell?.styleText(form: menu)
                    cell?.index = indexPath
                    cell?.delegate = self
                    switch menu.title{
                    case "* Jenis Kelamin":
                        cell?.txtField.configPicker()
                        cell?.txtField.setArr(data: BKDNDataArray.getListJenisKelamin())
                    case "* Tanggal Lahir":
                        cell?.txtField.configDate()
                    case "* Pekerjaan":
                        cell?.txtField.configPicker()
                        cell?.txtField.setArr(data: BKDNDataArray.getListPekerjaan())
                    case "* Provinsi":
                        cell?.txtField.configPicker()
                        cell?.txtField.setArr(data: MOList.shared?.province ?? [])
                    case "* Kode POS":
                        cell?.txtField.configText()
                        cell?.txtField.keyboardType = .numberPad
                    case "* Nomor NIK":
                        cell?.txtField.configText()
                        cell?.txtField.keyboardType = .numberPad
                    default:
                        cell?.txtField.configText()
                    }
                    return cell!
                }
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
                let menu = arrMenu[indexPath.row]
                switch menu.style{
                case .textView:
                    return 166
                default:
                    return 70
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension VCInformPribadi: TVCFormTextDelegate{
    func changeText(str: String, ind: IndexPath) {
        let menu = arrMenu[ind.row]
        menu.setContent(con: str)
        arrMenu[ind.row] = menu
    }
}

extension VCInformPribadi: TVCButtonDelegate{
    @objc func actionButton1() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionButton2() {
        if validate(){
            loading.startLoading()
            
            let api = ADMSubmitKilat1()
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
    
    func validate() -> Bool{
        var msg = ""
        
        if arrMenu[0].content.count <= 0{
            msg = "Tempat Lahir tidak boleh kosong"
        }
        else if arrMenu[1].content.count <= 0{
            msg = "Jenis Kelamin tidak boleh kosong"
        }
        else if arrMenu[2].content.count <= 0{
            msg = "Tanggal Lahir tidak boleh kosong"
        }
        else if arrMenu[3].content.count <= 0{
            msg = "Alamat tidak boleh kosong"
        }
        else if arrMenu[4].content.count <= 0{
            msg = "Kota tidak boleh kosong"
        }
        else if arrMenu[5].content.count <= 0{
            msg = "Provinsi tidak boleh kosong"
        }
        else if arrMenu[6].content.count <= 0{
            msg = "Kode POS tidak boleh kosong"
        }
        else if arrMenu[7].content.count <= 0{
            msg = "Pekerjaan tidak boleh kosong"
        }
        else if arrMenu[8].content.count <= 0{
            msg = "Nomor NIK tidak boleh kosong"
        }
        else{
            return true
        }
        
        let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
        self.present(alert, animated: true, completion: nil)
        return false
    }
}
