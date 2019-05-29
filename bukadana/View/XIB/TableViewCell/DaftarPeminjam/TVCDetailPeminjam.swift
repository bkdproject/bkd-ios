//
//  TVCDetailPeminjam.swift
//  bukadana
//
//  Created by Gaenael on 3/4/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCDetailPeminjamDelegate {
    func actionBiayai()
}

class TVCDetailPeminjam: UITableViewCell {
    
    var delegate: TVCDetailPeminjamDelegate?
    
    @IBOutlet weak var vwPendanaan: UIView!
    @IBOutlet weak var vwPinjaman: UIView!
    @IBOutlet weak var btnBiayai: UIButton!
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var lblPinjam: UILabel!
    @IBOutlet weak var lblPendana: UILabel!
    @IBOutlet weak var lblKuota: UILabel!
    @IBOutlet weak var lblLender: UILabel!
    
    @IBOutlet weak var lblNama: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblGrade: UILabel!
    @IBOutlet weak var lblTenor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
        config()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(){
        BKDNView.radius(vw: [vwPendanaan, vwPinjaman, btnBiayai], rad: 8)
    }
    
    func setData(data: Dictionary<String,Any>){
        let pinjaman = data["total_pinjaman"] as? String ?? "0"
        let pendana  = data["total_pendanaan"] as? String ?? "0"
        var kuota    = data["kuota_dana"] as? String ?? "0%"
        let lender   = data["total_lender"] as? String ?? "0"
        
        let nama  = data["nama_peminjam"] as? String ?? ""
        let no    = data["no_transaksi_pinjaman"] as? String ?? ""
        let grade = data["grade_peminjam"] as? String ?? ""
        let tenor = data["tenor"] as? String ?? "0"
        
        kuota        = kuota.replacingOccurrences(of: "%", with: "")
        
        let kuotaN   = Float((Float(kuota) ?? 0) / 100)
        
        lblPinjam.text  = "Rp " + BKDNCurrency.formatCurrency(UInt32(pinjaman) ?? 0)
        lblPendana.text = "Rp " + BKDNCurrency.formatCurrency(UInt32(pendana) ?? 0)
        
        lblKuota.text = "Kuota dana \(kuota)%"
        progress.setProgress(kuotaN, animated: true)
        lblLender.text = "\(lender) Mengikuti pendanaan ini"
        
        lblNama.text  = nama
        lblNo.text    = no
        lblGrade.text = grade
        lblTenor.text = tenor
    }
    
    @IBAction func actionBiayai(_ sender: Any) {
        self.delegate?.actionBiayai()
    }
}
