//
//  TVCButton.swift
//  bukadana
//
//  Created by Gaenael on 1/20/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCButtonDelegate {
    func actionButton1()
    func actionButton2()
}

class TVCButton: UITableViewCell {
    
    var delegate: TVCButtonDelegate?
    
    @IBOutlet weak var btnKembali: UIButton!
    @IBOutlet weak var btnBiayai: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configButtonPinjaman(){
        BKDNView.radius(vw: [btnBiayai, btnKembali], rad: 10)
        btnBiayai.addTarget(self, action: #selector(actionButton2), for: .touchUpInside)
    }
    
    func configForm(){
        BKDNView.radius(vw: [btnBiayai, btnKembali], rad: 10)
        btnKembali.addTarget(self, action: #selector(actionButton1), for: .touchUpInside)
        btnBiayai.addTarget(self, action: #selector(actionButton2), for: .touchUpInside)
        btnBiayai.setTitle("Selanjutnya", for: .normal)
        btnKembali.setTitle("Sebelumnya", for: .normal)
    }
    
    func configFormNext(){
        BKDNView.radius(vw: btnBiayai, rad: 10)
        btnBiayai.addTarget(self, action: #selector(actionButton2), for: .touchUpInside)
        btnBiayai.setTitle("Selanjutnya", for: .normal)
    }
    
    @objc func actionButton1(){
        delegate?.actionButton1()
    }
    
    @objc func actionButton2(){
        delegate?.actionButton2()
    }
    
}
