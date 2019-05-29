//
//  BKDNTextViewProfile.swift
//  bukadana
//
//  Created by Gaenael on 2/13/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BKDNTextViewProfile: UIView {
    
    var label = UILabel()
    var vwContent = UIView()
    var textView: UITextView = UITextView()
    
    var lblPlaceholder = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        
        label      = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 14))
        label.font = BKDNFont.getFont(name: .Montserrat, type: .Medium, size: 14)
        label.text = "Title"
        label.textColor = UIColor.lightGray
        self.addSubview(label)
        
        let cLeft  = BKDNConstraints.setConstraintReg(types: .leading, typesTo: .leading, cons: 8, item: label, toItem: self)
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
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.delegate = self
        vwContent.addSubview(textView)
        
        let cLeft   = BKDNConstraints.setConstraintReg(types: .leading, typesTo: .leading, cons: 4, item: textView, toItem: vwContent)
        let cTop   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .top, cons: 0, item: textView, toItem: vwContent)
        let cRight   = BKDNConstraints.setConstraintReg(types: .trailing, typesTo: .trailing, cons: 0, item: textView, toItem: vwContent)
        let cBottom = BKDNConstraints.setConstraintReg(types: .bottom, typesTo: .bottom, cons: 0, item: textView, toItem: vwContent)
        vwContent.addConstraints([cLeft, cTop, cRight, cBottom])
        
        self.lblPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        vwContent.addSubview(lblPlaceholder)
        let cLeft1   = BKDNConstraints.setConstraintReg(types: .leading, typesTo: .leading, cons: 10, item: lblPlaceholder, toItem: vwContent)
        let cTop1   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .top, cons: 8, item: lblPlaceholder, toItem: vwContent)
        vwContent.addConstraints([cLeft1, cTop1])
        
        self.lblPlaceholder.font      = UIFont(name: "HelveticaNeue", size: 12)
        self.lblPlaceholder.textColor = .lightGray
    }
    
    func setPlaceholder(placeholder: String){
        self.lblPlaceholder.text = placeholder
    }
    
    func setData(data: MFormProfile){
        self.label.text = data.title
        self.lblPlaceholder.text = data.placeholder
        self.textView.text = data.content
        
        lblPlaceholder.isHidden = textView.text.count > 0
    }
    
    func setData(data: MFormText){
        self.label.text          = data.title
        self.lblPlaceholder.text = data.placeholder
    }
}

extension BKDNTextViewProfile: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceholder.isHidden = textView.text.count > 0
    }
}
