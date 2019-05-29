//
//  TVCMenuHeader.swift
//  bukadana
//
//  Created by Gaenael on 1/21/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class TVCMenuHeader: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSaldo: UILabel!
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var lblProgress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle  = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configView(){
        BKDNView.radius(vw: imgView, rad: 32)
        
        let userdata  = BKDNUserDataModel.getData()
        let usersaldo = BKDNUserSaldoModel.getData()
        
        let strProg  = userdata.peringkat_pengguna_persentase
        let strFloat = Float(strProg ?? "0") ?? 0
        let fl       = strFloat / 100
        
        let saldo = usersaldo.saldo
        let str   = "\(BKDNCurrency.formatCurrency(UInt32(saldo)))"
        
        lblName.text  = userdata.Nama_pengguna ?? ""
        lblSaldo.text = "\(str) IDR"
        lblProgress.text = "\(strProg ?? "0")% Profile Terselesaikan"
        progress.progress = fl
    }
}
