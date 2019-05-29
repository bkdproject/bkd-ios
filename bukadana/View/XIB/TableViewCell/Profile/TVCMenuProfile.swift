//
//  TVCMenuUbahProfile.swift
//  bukadana
//
//  Created by Gaenael on 1/28/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCMenuProfileDelegate {
    func actionUpdate(tag: Int)
    func reset()
}

class TVCMenuProfile: UITableViewCell {

    var delegate : TVCMenuProfileDelegate?
    
    @IBOutlet weak var txtField1: BKDNFormProfile!
    @IBOutlet weak var txtField2: BKDNFormProfile!
    @IBOutlet weak var txtField3: BKDNFormProfile!
    @IBOutlet weak var txtField4: BKDNFormProfile!
    @IBOutlet weak var txtField5: BKDNFormProfile!
    @IBOutlet weak var txtField6: BKDNFormProfile!
    @IBOutlet weak var txtField7: BKDNFormProfile!
    @IBOutlet weak var txtField8: BKDNFormProfile!
    @IBOutlet weak var txtField9: BKDNFormProfile!
    @IBOutlet weak var txtField10: BKDNFormProfile!
    
    @IBOutlet weak var txtView1: BKDNTextViewProfile!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var vwTouchUp: UIView!
    
    var data     = [MFormProfile]()
    var arrBank  = MOList.shared?.bank ?? []
    var arrProv  = MOList.shared?.province ?? []
    var arrGender = BKDNDataArray.getListJenisKelamin()
    
    var arrPendidikan = BKDNDataArray.getListPendidikan()
    var arrPekerjaan  = BKDNDataArray.getListPekerjaan()
    
    let dt = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        config()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(){
        BKDNView.radius(vw: vwContent, rad: 8)
        BKDNView.border(vw: vwContent)
    }
    
    func setInformasiAkun(data: [MFormProfile]){
        BKDNView.radius(vw: btnUpdate, rad: 4)
        txtField1.setData(data: data[0])
        txtField2.setData(data: data[1])
        txtField3.setData(data: data[2])
        txtField4.setData(data: data[3])
        txtField5.setData(data: data[4])
        txtField6.setData(data: data[5])
        txtField7.setData(data: data[6])
        txtField8.setData(data: data[7])
        txtField9.setData(data: data[8])
        txtField10.setData(data: data[9])
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.tag = 1
        txtField7.textField.inputView = picker
        
        let gender = UIPickerView()
        gender.dataSource = self
        gender.delegate = self
        gender.tag = 11
        txtField3.textField.inputView = gender
        
        let pendidikan = UIPickerView()
        pendidikan.dataSource = self
        pendidikan.delegate = self
        pendidikan.tag = 12
        txtField8.textField.inputView = pendidikan
        
        let pekerjaan = UIPickerView()
        pekerjaan.dataSource = self
        pekerjaan.delegate = self
        pekerjaan.tag = 13
        txtField9.textField.inputView = pekerjaan
        
        dt.datePickerMode = UIDatePicker.Mode.date
        txtField4.textField.inputView = dt
        dt.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        
        txtField2.textField.keyboardType = .numberPad
        txtField6.textField.keyboardType = .numberPad
        if txtField6.textField.text == ""{
            txtField6.textField.isUserInteractionEnabled = true
        }
        else{
            txtField6.textField.isUserInteractionEnabled = false
        }
        
        txtField10.setData(data: data[9])
        txtField10.textField.keyboardType = .numberPad
        txtField10.textField.delegate = self
        
        btnUpdate.tag = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(reset))
        vwTouchUp.addGestureRecognizer(tap)
    }
    
    @objc func handleDatePicker() {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.txtField4.textField.text = dateFormatter.string(from: dt.date)
    }
    
    func setUbahPassword(){
        BKDNView.radius(vw: btnUpdate, rad: 4)
        txtField1.setData(data: MFormProfile(title: "Old Password", ph: "", content: ""))
        txtField2.setData(data: MFormProfile(title: "New Password", ph: "", content: ""))
        txtField3.setData(data: MFormProfile(title: "Confirm Password", ph: "", content: ""))
        
        txtField1.addTextPassword()
        txtField2.addTextPassword()
        txtField3.addTextPassword()
        
        btnUpdate.tag = 1
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(reset))
        vwTouchUp.addGestureRecognizer(tap)
    }
    
    func setInformasiAlamat(data: [MFormProfile]){
        BKDNView.radius(vw: btnUpdate, rad: 4)
        txtView1.setData(data: data[0])
        txtField1.setData(data: data[1])
        txtField2.setData(data: data[2])
        txtField3.setData(data: data[3])
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.tag = 2
        txtField2.textField.inputView = picker
        
        txtField3.textField.keyboardType = .numberPad
        
        btnUpdate.tag = 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(reset))
        vwTouchUp.addGestureRecognizer(tap)
    }
    
    @objc func reset(){
        delegate?.reset()
    }
    
    func setDefault(row: Int){
        switch row {
        case 0:
            lblTitle.text = "Informasi Akun"
        case 1:
            lblTitle.text = "Ubah Password"
        default:
            lblTitle.text = "Informasi Alamat"
        }
    }
    
    @IBAction func actionUpdate(_ sender: UIButton) {
        let tag = sender.tag
        delegate?.actionUpdate(tag: tag)
    }
}

extension TVCMenuProfile: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView.tag == 1{
            return self.arrBank.count
        }
        else if pickerView.tag == 11{
            return self.arrGender.count
        }
        else if pickerView.tag == 12{
            return self.arrPendidikan.count
        }
        else if pickerView.tag == 13{
            return self.arrPekerjaan.count
        }
        else{
            return self.arrProv.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return arrBank[row]["title"]
        }
        else if pickerView.tag == 11{
            return arrGender[row]["title"]
        }
        else if pickerView.tag == 12{
            return arrPendidikan[row]["title"]
        }
        else if pickerView.tag == 13{
            return arrPekerjaan[row]["title"]
        }
        else{
            return arrProv[row]["title"]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView.tag == 1{
            let type = arrBank[row]["title"]
            self.txtField7.textField.text = type
        }
        else if pickerView.tag == 11{
            let type = arrGender[row]["title"]
            self.txtField3.textField.text = type
        }
        else if pickerView.tag == 12{
            let type = arrPendidikan[row]["title"]
            self.txtField8.textField.text = type
        }
        else if pickerView.tag == 13{
            let type = arrPekerjaan[row]["title"]
            self.txtField9.textField.text = type
        }
        else{
            let type = arrProv[row]["title"]
            self.txtField2.textField.text = type
        }
    }
}

extension TVCMenuProfile: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.compactMap({ Int(String($0)) }).count ==
            string.count else { return false }
        
        let text = textField.text ?? ""
        
        if string.count == 0 {
            textField.text = String(text.dropLast()).chunkFormatted()
        }
        else {
            let newText = String((text + string)
                .filter({ $0 != "-" }).prefix(19))
            textField.text = newText.chunkFormatted()
        }
        return false
    }
}
