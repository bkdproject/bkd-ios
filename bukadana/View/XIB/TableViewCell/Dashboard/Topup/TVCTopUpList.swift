//
//  TVCRedeemList.swift
//  bukadana
//
//  Created by Gaenael on 2/17/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class TVCTopUpList: UITableViewCell {

    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblNoTransaksi: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTanggal: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        config()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(){
        var frame = vwContent.frame
        frame.origin.x = 0
        frame.origin.y = 0
        frame.size.width = BKDNFrame.getWidht() - 32
        BKDNView.setShadow3(vw: vwContent, bounds: frame)
        
        BKDNView.setShadow3(vw: vwContent, bounds: frame)
    }
    
    func setData(data: Dictionary<String, Any>){
        var dt = data["tgl_top_up"] as? String ?? ""
        dt = BKDNDate.format(from: dt, from: .dtFULL, to: .dtV2)
        
        lblNoTransaksi.text = data["kode_top_up"] as? String
        lblTotal.text       = "Rp \(data["jml_top_up"] as? String ?? "0")"
        lblTanggal.text     = dt
        if let status = data["status_top_up"] as? String{
            lblStatus.text = status
            if status == "pending"{
                vwContent.backgroundColor = BKDNColor.get(hex: .yellow)
            }
            else{
                vwContent.backgroundColor = .white
            }
        }
    }
    
    func setDataReeem(data: Dictionary<String, Any>){
        var dt = data["redeem_date"] as? String ?? ""
        dt = BKDNDate.format(from: dt, from: .dtFULL, to: .dtV2)
        
        lblNoTransaksi.text = data["redeem_kode"] as? String
        lblTotal.text       = "Rp \(data["redeem_amount"] as? String ?? "0")"
        lblTanggal.text     = dt
        lblStatus.text      = data["redeem_status"] as? String
    }
}
