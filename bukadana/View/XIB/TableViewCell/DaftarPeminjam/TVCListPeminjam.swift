//
//  TVCListPeminjam.swift
//  bukadana
//
//  Created by Gaenael on 2/25/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCListPeminjamDelegate {
    func actionDetail(row: Int)
}

class TVCListPeminjam: UITableViewCell {
    
    var delegate : TVCListPeminjamDelegate?
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var btnDetail: UIButton!
    
    @IBOutlet weak var lblTransaksi: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTerm: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblDana: UILabel!
    @IBOutlet weak var lblGrade: UILabel!
    @IBOutlet weak var lblLender: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    var index = IndexPath()
    
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
        var frames        = vwContent.frame
        frames.origin.y   = 0
        frames.origin.x   = 0
        frames.size.width = BKDNFrame.getWidht() - (16 * 2)
        
        BKDNView.setShadow3(vw: vwContent, bounds: frames)
        BKDNView.radius(vw: btnDetail, rad: 4)
    }
    
    func setData(data: Dictionary<String,Any>){
        let price1 = data["total_pinjam"] as? String ?? "0"
        let str1   = "Rp \(price1)"
        
        let price2 = data["total_pendanaan"] as? String ?? "0"
        let str2   = "Rp \(price2)"
        
        let prog    = (data["kuota_dana"] as? String ?? "0%")
        let newProg = prog.replacingOccurrences(of: "%", with: "")
        let progF = Float(newProg) ?? 0
        
        lblTransaksi.text = data["transaksi_id"] as? String
        lblName.text   = data["nama_peminjam"] as? String
        lblTerm.text   = "\(data["product_title"] as? String ?? "0")"
        lblTotal.text  = str1
        lblDana.text   = str2
        lblGrade.text  = data["peringkat_pengguna"] as? String
        lblLender.text = "\(data["total_lender"] as? String ?? "0") Orang"
        lblProgress.text = prog
        progress.progress = progF/100
    }
    
    @IBAction func ActionDetail(_ sender: Any) {
        delegate?.actionDetail(row: index.row)
    }
}
