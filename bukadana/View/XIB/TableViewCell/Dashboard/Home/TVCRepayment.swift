//
//  TVCRepayment.swift
//  bukadana
//
//  Created by Gaenael on 1/7/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class TVCRepayment: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblJumlah: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: Dictionary<String, Any>){
        let total    = data["nominal_transaksi"] as? String ?? "0"
        lblTitle.text  = data["title_transaksi"] as? String
        lblDesc.text   = "Jatuh Tempo: \(data["jatuh_tempo_transaksi"] as? String ?? "")"
        lblJumlah.text = "Rp \(total)"
    }
    
}
