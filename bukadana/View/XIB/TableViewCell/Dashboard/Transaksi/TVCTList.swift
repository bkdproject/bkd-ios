//
//  TVCTList.swift
//  bukadana
//
//  Created by Gaenael on 2/17/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCTListDelegate {
    func onClickDetail(tag: Int)
}

class TVCTList: UITableViewCell {
    
    var delegat: TVCTListDelegate?
    
    @IBOutlet weak var lblNoTransaksi: UILabel!
    @IBOutlet weak var lblNamaTransaksi: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblJenis: UILabel!
    @IBOutlet weak var lblJumlah: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var btnDetail: UIButton!
    
    @IBOutlet weak var vwContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        super.selectionStyle = .none
        config()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(){
        BKDNView.radius(vw: btnDetail, rad: 16)
        
        var frame = vwContent.frame
        frame.origin.x = 0
        frame.origin.y = 0
        frame.size.width = BKDNFrame.getWidht() - 32
        BKDNView.setShadow3(vw: vwContent, bounds: frame)
    }
    
    func setData(data: Dictionary<String,Any>){
        lblNoTransaksi.text   = data["transaksi_id"] as? String
        lblNamaTransaksi.text = data["product_title"] as? String
        lblStatus.text        = data["transaksi_status"] as? String
        lblJenis.text         = data["type_business_name"] as? String
        
        let jml               = data["totalrp"] as? String ?? "0"
        let total             = data["total_approve"] as? String ?? "0"
        lblJumlah.text        = "Rp " + jml
        lblTotal.text         = "Rp " + total
    }
    
    @IBAction func detail(_ sender: UIButton) {
        self.delegat?.onClickDetail(tag: sender.tag)
    }
}
