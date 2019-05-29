//
//  BKDNTextField.swift
//  bukadana
//
//  Created by Gaenael on 2/12/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol BKDNTextFieldDelegate {
    func didSelect(name:String)
}

class BKDNTextField: UITextField {
    
    var delegat : BKDNTextFieldDelegate?
    
    var picker     = UIPickerView()
    let datePicker = UIDatePicker()
    
    var arrPicker  = [[String:String]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autocorrectionType = .no
    }
    
    func configDate(){
        datePicker.datePickerMode = UIDatePicker.Mode.date
        self.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    @objc func handleDatePicker() {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.text = dateFormatter.string(from: datePicker.date)
        self.delegat?.didSelect(name: self.text ?? "")
    }
    
    func configText(){
        self.inputView    = nil
        self.keyboardType = .default
    }
    
    func configPicker(){
        picker.dataSource = self
        picker.delegate   = self
        self.inputView = picker
    }
    
    func setArr(data: [[String:String]]){
        self.arrPicker = data
        picker.reloadAllComponents()
    }
}

extension BKDNTextField: UIPickerViewDataSource, UIPickerViewDelegate{
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
        let title = arrPicker[row]["title"] ?? ""
        self.delegat?.didSelect(name: title)
        self.text = title
    }
}
