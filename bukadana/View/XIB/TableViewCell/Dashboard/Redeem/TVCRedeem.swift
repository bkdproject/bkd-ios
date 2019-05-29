//
//  TVCRedeem.swift
//  bukadana
//
//  Created by Gaenael on 2/15/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCRedeemDelegate {
    func redeemSubmit(bank: String, no: String, jml: String)
}

class TVCRedeem: UITableViewCell {

    var delegate: TVCRedeemDelegate?
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var txtField1: BKDNFormProfile!
    @IBOutlet weak var txtField2: BKDNFormProfile!
    @IBOutlet weak var txtField3: BKDNFormProfile!
    
    var arrBank = MOList.shared?.bank ?? []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configHeader(){
        BKDNView.radius(vw: vwContent, rad: 8)
        BKDNView.radius(vw: btnUpdate, rad: 22)
        
        var frames        = vwContent.frame
        frames.origin.y   = 0
        frames.origin.x   = 0
        frames.size.width = BKDNFrame.getWidht() - (16 * 2)
        
        BKDNView.setShadow3(vw: vwContent, bounds: frames)
        
        txtField1.setData(data: MFormProfile(title: "* Nama Bank", ph: "", content: ""))
        txtField2.setData(data: MFormProfile(title: "* No Rekening", ph: "", content: ""))
        txtField3.setData(data: MFormProfile(title: "* Jumlah", ph: "", content: ""))
        
        txtField2.textField.delegate     = self
        txtField2.textField.keyboardType = .numberPad
        txtField3.textField.keyboardType = .numberPad
        
        let picker        = UIPickerView()
        picker.dataSource = self
        picker.delegate   = self
        txtField1.textField.inputView = picker
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        let bank = txtField1.textField.text ?? ""
        var no   = txtField2.textField.text ?? ""
        no       = no.replacingOccurrences(of: " ", with: "")
        let jml  = txtField3.textField.text ?? ""

        self.delegate?.redeemSubmit(bank: bank, no: no, jml: jml)
    }
}

extension TVCRedeem: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.arrBank.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrBank[row]["title"]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let type = arrBank[row]["title"]
        self.txtField1.textField.text = type
    }
}

extension TVCRedeem: UITextFieldDelegate{
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
