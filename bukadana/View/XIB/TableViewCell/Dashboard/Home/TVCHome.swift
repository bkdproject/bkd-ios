//
//  TVCHome.swift
//  bukadana
//
//  Created by Gaenael on 1/4/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class TVCHome: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTipe: UILabel!
    @IBOutlet weak var lblDana: UILabel!
    
    @IBOutlet weak var lblNotif: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupProfile(){
        let data = BKDNUserDataModel.getData()
        BKDNView.radius(vw: imgProfile, rad: 25)
        lblDesc.text = data.Nama_pengguna?.uppercased()
        
    }
    
    func setupSaldo(){
        let data = BKDNUserSaldoModel.getData()
        BKDNView.radius(vw: self.lblNotif, rad: 8)
        lblDesc.text = "\(BKDNCurrency.formatCurrency(UInt32(data.saldo))) IDR"
        
        let tipe = Int(BUserKeyModel.getType())
        switch tipe {
        case 1:
            lblTipe.text = "Tipe User : Peminjam"
        default:
            lblTipe.text = "Tipe User : Pendana"
        }
    }
}
