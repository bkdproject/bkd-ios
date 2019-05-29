//
//  TVCHistory.swift
//  bukadana
//
//  Created by Gaenael on 1/28/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class TVCRekKoran: UITableViewCell {

    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblTipe: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.setContent()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(){
        var frames        = vwContent.frame
        frames.origin.y   = 0
        frames.origin.x   = 0
        frames.size.width = BKDNFrame.getWidht() - (16 * 2)
        
        BKDNView.setShadow3(vw: vwContent, bounds: frames)
        
        BKDNView.radius(vw: lblStatus, rad: 4)  
    }
    
    func setData(data: Dictionary<String, Any>){
        print(data)
        let price = data["amount_detail"] as? String ?? "0"
        let str   = "Rp \(price)"
        
        lblTipe.text    = data["tipe_dana_text"] as? String
        lblId.text      = data["kode_transaksi"] as? String
        lblNotes.text   = data["Notes"] as? String
        lblPrice.text   = str
        lblDate.text    = data["Date_transaction"] as? String
        
        let tipeDana = data["tipe_dana"] as? String ?? "1"
        switch tipeDana {
        case "1":
            lblTipe.textColor = BKDNColor.get(name: "f7941d")
        default:
            lblTipe.textColor = BKDNColor.get(name: "0f9ebc")
        }
        
    }
    
}
