



//
//  VCPOPTopup.swift
//  bukadana
//
//  Created by Gaenael on 2/23/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol VCPOPTopupDelegate{
    func submitPostApi(msg: String)
}

class VCPOPTopup: UIViewController {

    var delegate: VCPOPTopupDelegate?
    
    @IBOutlet weak var vwContent: UIView!
    
    @IBOutlet weak var txtField1: BKDNFormProfile!
    @IBOutlet weak var txtField2: BKDNFormProfile!
    @IBOutlet weak var txtField3: BKDNFormProfile!
    @IBOutlet weak var txtField4: BKDNFormProfile!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var vwBg: UIView!
    
    var menu    = [MFormProfile]()
    var arrBank = MOList.shared?.bank ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configView()
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        self.postTopup()
    }
    
    func configView(){
        menu = getMenu()
        BKDNView.radius(vw: vwContent, rad: 8)
        BKDNView.radius(vw: btnSubmit, rad: 8)
        
        txtField1.setData(data: menu[0])
        txtField2.setData(data: menu[1])
        txtField3.setData(data: menu[2])
        txtField4.setData(data: menu[3])
        
        txtField2.textField.keyboardType = .numberPad
        txtField4.textField.keyboardType = .numberPad
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        txtField3.textField.inputView = picker
        txtField2.textField.delegate  = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        vwBg.addGestureRecognizer(tap)
    }

    @objc func dismiss(gesture: UIGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    
    func postTopup(){
        if validate(){
            let api = ADTUSubmit()
            
            let name = txtField1.textField.text ?? ""
            var no   = txtField2.textField.text ?? ""
            no = no.replacingOccurrences(of: " ", with: "")
            
            let bank = txtField3.textField.text ?? ""
            let jml  = txtField4.textField.text ?? ""
            
            api.setParam(name: name, no: no, bank: bank, jml: jml)
            api.submit { (msg, err) in
                if err == nil{
                    self.dismiss(animated: false, completion: {
                        self.delegate?.submitPostApi(msg: msg)
                    })
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
        
        let name = txtField1.textField.text ?? ""
        var no   = txtField2.textField.text ?? ""
        no = no.replacingOccurrences(of: " ", with: "")
        let bank = txtField3.textField.text ?? ""
        let jml  = txtField4.textField.text ?? ""
        
        if name.count <= 0{
            msg = "Nama Rekening Anda tidak boleh kosong"
        }
        else if no.count <= 0{
            msg = "No Rekening Anda tidak boleh kosong"
        }
        else if no.count < 8{
            msg = "No Rekening minimal 8 digit"
        }
        else if bank.count <= 0{
            msg = "Bank Anda tidak boleh kosong"
        }
        else if jml.count <= 0{
            msg = "Jumlah tidak boleh kosong"
        }
        else{
            return true
        }
        
        let alert = BKDNAlert.showAlertErr(title: "Info", msg: msg)
        self.present(alert, animated: true, completion: nil)
        return false
    }
}

extension VCPOPTopup{
    func getMenu() -> [MFormProfile]{
        var arr = [MFormProfile]()
        arr.append(MFormProfile.init(title: "* Nama Rekening Anda", ph: "", content: ""))
        arr.append(MFormProfile.init(title: "* No Rekening Anda", ph: "", content: ""))
        arr.append(MFormProfile.init(title: "* Bank Anda", ph: "", content: ""))
        arr.append(MFormProfile.init(title: "* Jumlah", ph: "", content: ""))
        return arr
    }
}

extension VCPOPTopup: UIPickerViewDelegate, UIPickerViewDataSource{
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
        self.txtField3.textField.text = type
    }
}

extension VCPOPTopup: UITextFieldDelegate{
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
