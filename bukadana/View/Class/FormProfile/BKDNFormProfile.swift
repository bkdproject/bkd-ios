//
//  BKDNFormProfile.swift
//  bukadana
//
//  Created by Gaenael on 2/12/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BKDNFormProfile: UIView {
    
    var label = UILabel()
    var button1:     UIButton = UIButton()
    var vwContent = UIView()
    var textField: UITextField = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        
        self.vwContent.translatesAutoresizingMaskIntoConstraints = false
        label      = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 14))
        label.font = BKDNFont.getFont(name: .Montserrat, type: .Medium, size: 14)
        label.text = "Title"
        label.textColor = UIColor.lightGray
        self.addSubview(label)
        
        let cLeft   = BKDNConstraints.setConstraintReg(types: .leading, typesTo: .leading, cons: 8, item: label, toItem: self)
        let cTop   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .top, cons: 0, item: label, toItem: self)
        self.addConstraints([cLeft, cTop])
        
        
        addContentView()
        addText()
    }
    
    func setTitle(){
        label.text = ""
    }
    
    func addContentView(){
        self.vwContent.translatesAutoresizingMaskIntoConstraints = false
        BKDNView.radius(vw: vwContent, rad: 4)
        BKDNView.border(vw: vwContent)
        self.addSubview(vwContent)
        
        let cLeft   = BKDNConstraints.setConstraintReg(types: .leading, typesTo: .leading, cons: 8, item: vwContent, toItem: self)
        let cTop   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .bottom, cons: 4, item: vwContent, toItem: label)
        let cRight   = BKDNConstraints.setConstraintReg(types: .trailing, typesTo: .trailing, cons: 0, item: vwContent, toItem: self)
        let cBottom = BKDNConstraints.setConstraintReg(types: .bottom, typesTo: .bottom, cons: -4, item: vwContent, toItem: self)
        self.addConstraints([cLeft, cTop, cRight, cBottom])
    }
    
    func addText(){
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.placeholder = "tester"
        vwContent.addSubview(textField)
        
        let cLeft   = BKDNConstraints.setConstraintReg(types: .leading, typesTo: .leading, cons: 8, item: textField, toItem: vwContent)
        let cTop   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .top, cons: 0, item: textField, toItem: vwContent)
        let cRight   = BKDNConstraints.setConstraintReg(types: .trailing, typesTo: .trailing, cons: 0, item: textField, toItem: vwContent)
        let cBottom = BKDNConstraints.setConstraintReg(types: .bottom, typesTo: .bottom, cons: 0, item: textField, toItem: vwContent)
        vwContent.addConstraints([cLeft, cTop, cRight, cBottom])
    }
    
    func addTextPassword(){
        for c in vwContent.constraints{
            if c.firstAttribute == .trailing{
                c.constant = -44
            }
        }
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.setImage(UIImage(named: "ic_shape"), for: .normal)
        button1.addTarget(self, action: #selector(actionShowHidePass), for: .touchUpInside)
        
        vwContent.addSubview(button1)
        
        let bRight   = BKDNConstraints.setConstraintReg(types: .trailing, typesTo: .trailing, cons: -8, item: self.button1, toItem: vwContent)
        let bTop   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .top, cons: 8, item: self.button1, toItem: vwContent)
        let bBottom = BKDNConstraints.setConstraintReg(types: .bottom, typesTo: .bottom, cons: -8, item: self.button1, toItem: vwContent)
        self.addConstraints([bTop, bRight, bBottom])
        
        let bWidth = BKDNConstraints.setConstraintReg(types: .widht, cons: 32, item: self.button1)
        button1.addConstraint(bWidth)
        
        self.setPlaceholder(placeholder: "Password")
        self.textField.isSecureTextEntry = true
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
    
    func setData(data: MFormProfile){
        self.label.text            = data.title
        self.textField.placeholder = data.placeholder
        self.textField.text        = data.content
    }
}
