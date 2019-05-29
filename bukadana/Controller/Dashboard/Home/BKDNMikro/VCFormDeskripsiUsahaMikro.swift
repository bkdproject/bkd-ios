//
//  VCFormDeskripsiUsahaMikro.swift
//  bukadana
//
//  Created by Gaenael on 1/20/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCFormDeskripsiUsahaMikro: UIViewController {

    @IBOutlet weak var vwHeader: BKDNVHeader!
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currIndex = IndexPath()
    var arrMenu = [MFormText]()
    
    var loading = VHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        for n in getNIB() {
            BKDNView.registerNibTableView(tblView: tableView, nibName: n)
        }
        
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        bgImage.image = UIImage(named: "bg")
        
        vwHeader.setStyleForm(title: "Daftar BKDana Mikro", desc: "Beberapa langkah lagi untuk menjadi peminjam di BKDana. Silahkan lengkapi informasi dan data-data Anda terlebih dahulu.")
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
            getNibUpload(),
        ]
    }
    
    private func getNib()       -> String{ return "TVCFormText" }
    private func getNibTitle()  -> String{ return "TVCTitle" }
    private func getNibButton() -> String{ return "TVCButtonNext" }
    private func getNibUpload() -> String{ return "TVCFormUpload" }
    
    private func nextSegue()    -> String { return "toFormUploadUsahaMikro" }
    
    private func getTitle() -> MFormTitle{
        return MFormTitle.init(title: "Informasi Usaha", desc: "Silahkan masukan data diri Anda sebenar - benarnya.")
    }
    private func getMenu() -> [MFormText]{
        let data = BKDNUserDataModel.getData()
        return [
            MFormText.init(title: "* Deskripsi Usaha",  placeholder: "", content: data.deskripsi_usaha, style: .text),
            MFormText.init(title: "* Info Usaha", placeholder: "", content: data.foto_usaha_file, style: .upload),
            MFormText.init(title: "* Omzet Usaha", placeholder: "", content: data.omzet_usaha, style: .text),
            MFormText.init(title: "* Modal",  placeholder: "Modal", style: .text),
            MFormText.init(title: "* Margin",  placeholder: "Margin", content: data.margin_usaha, style: .text),
            MFormText.init(title: "* Biaya Operasional", placeholder: "Biaya Operasional", content: data.biaya_operasional_usaha, style: .text),
            MFormText.init(title: "* Laba Usaha untuk 3-12 bln terakhir", placeholder: "Laba Usaha", content: data.laba_usaha,  style: .text),
//            MFormText.init(title: "* Jumlah Bunga", placeholder: "Jumlah Bunga", style: .text),
            MFormText.init(title: "* Nama Bank",  placeholder: "-- Pilih --", content: data.nama_bank,  style: .dropdown),
//            MFormText.init(title: "* Ada analisa scoring dari data-data yang dikirim",  placeholder: "Analisa",  style: .text)
        ]
    }
    
}


extension VCFormDeskripsiUsahaMikro: UITableViewDelegate, UITableViewDataSource{
    
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
                switch menu.style{
                case .upload:
                    let cell      = tableView.dequeueReusableCell(withIdentifier: getNibUpload()) as? TVCFormUpload
                    cell?.index   = indexPath
                    cell?.delegat = self
                    cell?.styleUpload2(form: menu)
                    return cell!
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: getNib()) as? TVCFormText
                    cell?.styleText(form: menu)
                    cell?.delegate = self
                    cell?.index = indexPath
                    
                    switch menu.title{
                    case "* Nama Bank":
                        cell?.txtField.configPicker()
                        cell?.txtField.setArr(data: MOList.shared?.bank ?? [])
                    case "* Omzet Usaha":
                        cell?.txtField.configText()
                        cell?.txtField.keyboardType = .numberPad
                    case "* Modal":
                        cell?.txtField.configText()
                        cell?.txtField.keyboardType = .numberPad
                    case "* Biaya Operasional":
                        cell?.txtField.configText()
                        cell?.txtField.keyboardType = .numberPad
                    case "* Laba Usaha untuk 3-12 bln terakhir":
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
                case .upload:
                    return 193
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

extension VCFormDeskripsiUsahaMikro: TVCButtonDelegate{
    @objc func actionButton1() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionButton2() {
        if validate(){
            loading.startLoading()
            
            let api = ADMSubmitMikro2()
            api.setParam(model: self.arrMenu)
            api.setParamImage(model: self.arrMenu)
            api.uploadPhoto { (st, err) in
                self.loading.stopLoading()
                
                if st == "success"{
                    self.performSegue(withIdentifier: self.nextSegue(), sender: nil)
                }
                else{
                    let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Response Failed")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func validate() -> Bool{
        var msg = ""
        
        if arrMenu[0].content.count <= 0{
            msg = "Deskripsi Usaha tidak boleh kosong"
        }
        else if arrMenu[1].image == nil{
            msg = "Upload Foto Info Usaha"
        }
        else if arrMenu[2].content.count <= 0{
            msg = "Omzet Usaha tidak boleh kosong"
        }
        else if arrMenu[3].content.count <= 0{
            msg = "Modal tidak boleh kosong"
        }
        else if arrMenu[4].content.count <= 0{
            msg = "Margin tidak boleh kosong"
        }
        else if arrMenu[5].content.count <= 0{
            msg = "Biaya Operasional tidak boleh kosong"
        }
            //        else if arrMenu[6].content.count <= 0{
            //            msg = "Laba Usaha untuk 3-12 bln terakhir tidak boleh kosong"
            //        }
            //        else if arrMenu[7].content.count <= 0{
            //            msg = "Jumlah Bunga tidak boleh kosong"
            //        }
        else if arrMenu[7].content.count <= 0{
            msg = "Nama Bank tidak boleh kosong"
        }
            //        else if arrMenu[9].content.count <= 0{
            //            msg = "Ada analisa scoring dari data-data yang dikirim tidak boleh kosong"
            //        }
        else{
            return true
        }
        
        let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
        self.present(alert, animated: true, completion: nil)
        return false
    }
}

extension VCFormDeskripsiUsahaMikro: TVCFormTextDelegate{
    func changeText(str: String, ind: IndexPath) {
        let menu = arrMenu[ind.row]
        menu.setContent(con: str)
        arrMenu[ind.row] = menu
    }
}

extension VCFormDeskripsiUsahaMikro: TVCFormUploadDelegate{
    
    func changeImage(ind: IndexPath) {
        let alert = BKDNAlert.showAlertChangeImage(action: { (_) in
            self.clickCamera(ind: ind)
        }) { (_) in
            self.removeImg(ind: ind)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func clickCamera(ind: IndexPath) {
        currIndex    = ind
        let libPhoto = BPPhoto.init()
        libPhoto.galleryPicker.delegate = self
        libPhoto.openCamera(vc: self)
    }
    
    func removeImg(ind: IndexPath){
        let menu = arrMenu[ind.row]
        menu.setImg(ig: nil)
        arrMenu[ind.row] = menu
        self.tableView.reloadData()
    }
    
    func updateImage(ind: IndexPath, img: UIImage?) {
        let menu = arrMenu[ind.row]
        menu.setImg(ig: img)
        arrMenu[ind.row] = menu
//        self.tableView.reloadData()
    }
    
}

extension VCFormDeskripsiUsahaMikro: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let menu = arrMenu[currIndex.row]
        menu.setImg(ig: image)
        arrMenu[currIndex.row] = menu
        
        self.tableView.reloadData()
        
        picker.dismiss(animated: true, completion: nil)
    }
}
