//
//  TVCRegisterForm.swift
//  bukadana
//
//  Created by Gaenael on 1/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCRegisterFormDelegate {
    func toOtp()
    func register(fname: String, telp: String, email: String, pass: String, type: String, sdana: String)
}

class TVCRegisterForm: UITableViewCell {

    var delegate: TVCRegisterFormDelegate?

    @IBOutlet weak var txtName: BKDNVForm!
    @IBOutlet weak var txtEmail: BKDNVForm!
    @IBOutlet weak var txtPass: BKDNVForm!
    @IBOutlet weak var txtPhone: BKDNVForm!
    @IBOutlet weak var txtType: BKDNVForm!
    @IBOutlet weak var txtSumberDana: BKDNVForm!
    
    @IBOutlet weak var btnDaftar: UIButton!
    @IBOutlet weak var btnBantuan: UIButton!
    
    var type = ["Peminjam", "Pendana"]
    
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
        self.txtName.addText()
        self.txtName.setPlaceholder(placeholder: "Name")
        
        self.txtEmail.styleEmail()
        self.txtPass.stylePassword()
        
        self.txtPhone.styleNumeric()
        self.txtPhone.setPlaceholder(placeholder: "Phone (Recomended)")
        
        self.txtType.styleDropdown()
        self.txtType.setPlaceholder(placeholder: "Type")
        self.txtType.textField.text = "Peminjam"
        
        self.txtSumberDana.addText()
        self.txtSumberDana.setPlaceholder(placeholder: "Sumber Dana")
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        txtType.textField.inputView = picker
        
        self.btnDaftar.addTarget(self, action: #selector(register), for: .touchUpInside)
        self.btnBantuan.addTarget(self, action: #selector(toOtp), for: .touchUpInside)
        BKDNView.radius(vw: self.btnDaftar, rad: 22)
        
        checkType()
    }
    
    @objc func toOtp(){
        self.delegate?.toOtp()
    }
    @objc func register(){
        let name  = txtName.textField.text ?? ""
        let pass  = txtPass.textField.text ?? ""
        let email = txtEmail.textField.text ?? ""
        let telp  = txtPhone.textField.text ?? ""
        let type  = txtType.textField.text ?? ""
        let sdana = txtSumberDana.textField.text ?? ""
        
        self.delegate?.register(fname: name, telp: telp, email: email, pass: pass, type: type, sdana: sdana)
    }
    
    func checkType(){
        let type = txtType.textField.text ?? ""
        switch type {
        case "Pendana":
            txtSumberDana.alpha = 1
        default:
            txtSumberDana.alpha = 0
        }
    }
}

extension TVCRegisterForm: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.type.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let type = self.type[row]
        self.txtType.textField.text = type
        self.checkType()
    }
}
