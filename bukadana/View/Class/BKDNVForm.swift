//
//  BKDNVForm.swift
//  bukadana
//
//  Created by Gaenael on 1/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BKDNVForm: UIView {
    
    var textField:   UITextField = UITextField()
    var button1:     UIButton = UIButton()
    var picker     = UIPickerView()
    let datePicker = UIDatePicker()
    
    var arrPicker  = [[String:String]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
        
        self.backgroundColor    = .clear
        self.layer.borderColor  = UIColor.darkGray.withAlphaComponent(0.2).cgColor
        self.layer.borderWidth  = 0.5
        self.layer.cornerRadius = 4
    }
    
    func addText(){
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.textField)
        
        let cLeft   = BKDNConstraints.setConstraintReg(types: .leading, typesTo: .leading, cons: 8, item: self.textField, toItem: self)
        let cTop   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .top, cons: 0, item: self.textField, toItem: self)
        let cRight   = BKDNConstraints.setConstraintReg(types: .trailing, typesTo: .trailing, cons: 0, item: self.textField, toItem: self)
        let cBottom = BKDNConstraints.setConstraintReg(types: .bottom, typesTo: .bottom, cons: 0, item: self.textField, toItem: self)
        self.addConstraints([cLeft, cTop, cBottom, cRight])
    }
    
    func styleEmail(){
        self.addText()
        self.setPlaceholder(placeholder: "Email")
        self.textField.keyboardType = .emailAddress
    }
    
    func styleNumeric(){
        self.addText()
        self.setPlaceholder(placeholder: "Numeric")
        self.textField.keyboardType = .numberPad
    }
    
    func stylePassword(){
        self.addText()
        for c in self.constraints{
            if c.firstAttribute == .trailing{
                c.constant = -44
            }
        }
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.setImage(UIImage(named: "ic_shape"), for: .normal)
        button1.addTarget(self, action: #selector(actionShowHidePass), for: .touchUpInside)
        let i = CGFloat(16)
        button1.imageEdgeInsets = UIEdgeInsets(top: i, left: 12, bottom: i, right: 12)
        
        self.addSubview(button1)
        
        let bRight   = BKDNConstraints.setConstraintReg(types: .trailing, typesTo: .trailing, cons: 0, item: self.button1, toItem: self)
        let bTop   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .top, cons: 0, item: self.button1, toItem: self)
        let bBottom = BKDNConstraints.setConstraintReg(types: .bottom, typesTo: .bottom, cons: 0, item: self.button1, toItem: self)
        self.addConstraints([bTop, bRight, bBottom])
        
        let bWidth = BKDNConstraints.setConstraintReg(types: .widht, cons: 44, item: self.button1)
        button1.addConstraint(bWidth)
        
        self.setPlaceholder(placeholder: "Password")
        self.textField.isSecureTextEntry = true
    }
    
    func styleDropdown(){
        self.addText()
        for c in self.constraints{
            if c.firstAttribute == .trailing{
                c.constant = -44
            }
        }
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.setImage(UIImage(named: "ic_dropdown"), for: .normal)
        
        let i = CGFloat(18)
        button1.imageEdgeInsets = UIEdgeInsets(top: i, left: 16, bottom: i, right: 16)
        
        self.addSubview(button1)
        
        let bRight   = BKDNConstraints.setConstraintReg(types: .trailing, typesTo: .trailing, cons: 0, item: self.button1, toItem: self)
        let bTop   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .top, cons: 0, item: self.button1, toItem: self)
        let bBottom = BKDNConstraints.setConstraintReg(types: .bottom, typesTo: .bottom, cons: 0, item: self.button1, toItem: self)
        self.addConstraints([bTop, bRight, bBottom])
        
        let bWidth = BKDNConstraints.setConstraintReg(types: .widht, cons: 44, item: self.button1)
        button1.addConstraint(bWidth)
        
        self.setPlaceholder(placeholder: "Type2")
    }
    
    func setPlaceholder(placeholder: String){
        self.textField.placeholder = placeholder
    }
    
    @objc func actionShowHidePass(){
        if self.textField.isSecureTextEntry {
            self.textField.isSecureTextEntry = false
        }
        else{
            self.textField.isSecureTextEntry = true
        }
    }
    
    func configDate(){
        datePicker.datePickerMode = UIDatePicker.Mode.date
        self.textField.inputView  = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    @objc func handleDatePicker() {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.textField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func configPicker(){
        picker.dataSource = self
        picker.delegate   = self
    }
    func setArr(data: [[String:String]]){
        self.arrPicker = data
        picker.reloadAllComponents()
    }
}

extension BKDNVForm: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPicker.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrPicker[row]["title"]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(arrPicker[row])
    }
}

