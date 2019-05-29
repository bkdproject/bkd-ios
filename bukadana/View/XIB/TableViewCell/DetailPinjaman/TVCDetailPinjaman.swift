//
//  TVCDetailPinjaman.swift
//  bukadana
//
//  Created by Gaenael on 1/7/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit


class TVCDetailPinjaman: UITableViewCell {
    
    
    
    @IBOutlet weak var vwContent: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configPendanaan(){
        BKDNView.radius(vw: vwContent, rad: 4)
        BKDNView.border(vw: vwContent)
    }
    
    func configPinjaman(){
        BKDNView.radius(vw: vwContent, rad: 4)
        BKDNView.border(vw: vwContent)
    }
    
    func configInformasiPeminjam(){
        BKDNView.radius(vw: vwContent, rad: 4)
        BKDNView.border(vw: vwContent)
    }
}
