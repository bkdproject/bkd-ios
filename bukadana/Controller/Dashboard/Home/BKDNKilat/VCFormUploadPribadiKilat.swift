//
//  VCFormUploadPribadiKilat.swift
//  bukadana
//
//  Created by Gaenael on 1/20/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCFormUploadPribadiKilat: UIViewController {
    
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
            getNibUpload(),
        ]
    }
    
    private func getNib()       -> String{ return "TVCFormText" }
    private func getNibTitle()  -> String{ return "TVCTitle" }
    private func getNibButton() -> String{ return "TVCButtonNext" }
    private func getNibUpload() -> String{ return "TVCFormUpload" }
    
    private func getTitle() -> MFormTitle{
        return MFormTitle.init(title: "Upload Dokumen", desc: "Upload dokumen - dokumen anda sebagai tolak ukur kredit skor anda")
    }
    private func getMenu() -> [MFormText]{
        let data = BKDNUserDataModel.getData()
        return [
            MFormText.init(title: "* Upload Foto",                    placeholder: "", content: data.foto_file, style: .upload),
            MFormText.init(title: "* Upload NIK File",                placeholder: "", content: data.nik_file, style: .upload),
            MFormText.init(title: "* Nomor Rekening",                 placeholder: "Nomor Rekening", content: data.Nomor_rekening, style: .text),
            MFormText.init(title: "* Jumlah Pinjaman",                placeholder: "-- Pilih --", style: .dropdown),
            MFormText.init(title: "* Tenor",                          placeholder: "-- Pilih --", style: .dropdown),
            MFormText.init(title: "* Foto Surat Keterangan Bekerja",  placeholder: "", content: data.foto_surat_ket_kerja, style: .upload),
            MFormText.init(title: "* Gaji Bulanan",                   placeholder: "Gaji Bulanan", content: data.gaji, style: .text),
            MFormText.init(title: "* Foto Slip Gaji",                 placeholder: "Foto Slip Gaji", content: data.foto_slip_gaji, style: .upload),
            MFormText.init(title: "* Foto Pegang IDCard/eKTP",        placeholder: "", content: data.foto_pegang_idcard, style: .upload)
        ]
    }

}


extension VCFormUploadPribadiKilat: UITableViewDelegate, UITableViewDataSource{
    
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
                        let cell = tableView.dequeueReusableCell(withIdentifier: getNibUpload(), for: indexPath) as? TVCFormUpload
                        cell?.index = indexPath
                        cell?.delegat = self
                        cell?.styleUpload2(form: menu)
                        return cell!
                    default:
                        let cell = tableView.dequeueReusableCell(withIdentifier: getNib()) as? TVCFormText
                        cell?.styleText(form: menu)
                        cell?.delegate = self
                        cell?.index = indexPath
                        switch menu.title{
                        case "* Jumlah Pinjaman":
                            cell?.txtField.configPicker()
                            cell?.txtField.setArr(data: MOList.shared?.kilat.convertPinjamanPicker() ?? [])
                        case "* Tenor":
                            cell?.txtField.configPicker()
                            cell?.txtField.setArr(data: MOList.shared?.kilat.convertProductsPicker() ?? [])
                        case "* Nomor Rekening":
                            cell?.txtField.configText()
                            cell?.txtField.keyboardType = .numberPad
                        case "* Gaji Bulanan":
                            cell?.txtField.configText()
                            cell?.txtField.keyboardType = .numberPad
                        default:
                            cell?.txtField.configText()
                            break
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

extension VCFormUploadPribadiKilat: TVCButtonDelegate{
    @objc func actionButton1() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionButton2() {
        if validate(){
            loading.startLoading()
            let api = ADMSubmitKilat3()
            api.setParam(model: self.arrMenu)
            api.setParamImage(model: self.arrMenu)
            api.uploadPhoto { (st, err) in
                self.loading.stopLoading()
                
                if st == "success"{
                    let alert = BKDNAlert.showAlertSuccess(title: "Success", msg: "Berhasil", action: { (_) in
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Response Failed")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension VCFormUploadPribadiKilat: TVCFormTextDelegate{
    func changeText(str: String, ind: IndexPath) {
        let menu = arrMenu[ind.row]
        menu.setContent(con: str)
        arrMenu[ind.row] = menu
    }
}

extension VCFormUploadPribadiKilat: TVCFormUploadDelegate{
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
    
//    func updateImage(ind: IndexPath, img: UIImage?) {
//        let menu = arrMenu[ind.row]
//        menu.setImg(ig: img)
//        arrMenu[ind.row] = menu
//        self.tableView.reloadData()
//    }
    
    func updateImage(ind: IndexPath, img: UIImage?) {
        let menu = arrMenu[ind.row]
        menu.setImg(ig: img)
        arrMenu[ind.row] = menu
    }
}

extension VCFormUploadPribadiKilat: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
    
    func validate() -> Bool{
        var msg = ""
        
        if arrMenu[0].image == nil{
            msg = "Silahkan upload foto anda"
        }
        else if arrMenu[1].image == nil{
            msg = "Upload Foto NIK File anda"
        }
        else if arrMenu[2].content.count <= 0{
            msg = "Nomor Rekening tidak boleh kosong"
        }
        else if arrMenu[3].content.count <= 0{
            msg = "Silahkan pilih Jumlah Pinjaman boleh kosong"
        }
        else if arrMenu[4].content.count <= 0{
            msg = "Silahkan pilih Tenor boleh kosong"
        }
        else if arrMenu[5].image == nil{
            msg = "Upload Foto Surat Keterangan Bekerja"
        }
        else if arrMenu[6].content.count <= 0{
            msg = "Silahkan isi Gaji Bulanan tidak boleh kosong"
        }
        else if arrMenu[7].image == nil{
            msg = "Upload Foto Slip Gaji"
        }
        else if arrMenu[8].image == nil{
            msg = "Upload Foto Pegang IDCard/eKTP"
        }
        else{
            return true
        }
        
        let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
        self.present(alert, animated: true, completion: nil)
        return false
    }
}

