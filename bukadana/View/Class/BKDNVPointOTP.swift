//
//  BKDNVPointOTP.swift
//  bukadana
//
//  Created by Gaenael on 1/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BKDNVPointOTP: UIView {

    var title: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .groupTableViewBackground
        BKDNView.radius(vw: self, rad: 4)
        
        self.setTitle(t: "1")
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title.font = UIFont(name: "Helvetica-Bold", size: 24)
        self.title.textAlignment = .center
        self.addSubview(self.title)
        
        let cLeft   = BKDNConstraints.setConstraintReg(types: .leading, typesTo: .leading, cons: 0, item: self.title, toItem: self)
        let cTop   = BKDNConstraints.setConstraintReg(types: .top, typesTo: .top, cons: 0, item: self.title, toItem: self)
        let cRight   = BKDNConstraints.setConstraintReg(types: .trailing, typesTo: .trailing, cons: 0, item: self.title, toItem: self)
        let cBottom = BKDNConstraints.setConstraintReg(types: .bottom, typesTo: .bottom, cons: 0, item: self.title, toItem: self)
        self.addConstraints([cLeft, cTop, cBottom, cRight])
    }
    
    func setTitle(t: String){
        title.text = t
    }
}
