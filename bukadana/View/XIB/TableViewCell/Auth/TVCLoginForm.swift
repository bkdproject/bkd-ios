//
//  TVCLoginForm.swift
//  bukadana
//
//  Created by Gaenael on 1/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCLoginFormDelegate {
    func toDaftar()
    func login(name: String, pass: String)
}

class TVCLoginForm: UITableViewCell {
    var delegate: TVCLoginFormDelegate?
    
    @IBOutlet weak var txtEmail: BKDNVForm!
    @IBOutlet weak var txtPass: BKDNVForm!
    
    @IBOutlet weak var btnMasuk: UIButton!
    @IBOutlet weak var btnDaftarDisini: UIButton!
    @IBOutlet weak var btnLupaPassword: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.config()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(){
        self.txtEmail.styleEmail()
        self.txtPass.stylePassword()
        
        BKDNView.radius(vw: self.btnMasuk, rad: 22)
        
        self.btnMasuk.addTarget(self, action: #selector(actionLogin), for: .touchUpInside)
        self.btnDaftarDisini.addTarget(self, action: #selector(toDaftar), for: .touchUpInside)
    }
    
    @objc func toDaftar(){
        self.delegate?.toDaftar()
    }
    
    @objc func actionLogin(){
        self.delegate?.login(name: txtEmail.textField.text ?? "", pass: txtPass.textField.text ?? "")
    }
}
