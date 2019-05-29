//
//  TVCTDRiwayat.swift
//  bukadana
//
//  Created by PT SPRINT ASIA on 01/03/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCTDRiwayatDelegate {
    func bayar(index: IndexPath)
}

class TVCTDRiwayat: UITableViewCell {
    
    var delegat: TVCTDRiwayatDelegate?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var vwCircle: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var vwContent: UIView!
    
    @IBOutlet weak var vwSepTop: UIView!
    @IBOutlet weak var btnBayar: UIButton!
    
    var currindex = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupContent(datas: Dictionary<String, Any>?){
        BKDNView.radius(vw: vwCircle, rad: 18)
        
        BKDNView.radius(vw: vwContent, rad: 8)
        BKDNView.border(vw: vwContent)
        
        if let dt = datas?["jatuh_tempo"] as? String{
            self.lblDate.text = dt
        }
        
        BKDNView.borderWithColor(vw: vwCircle, color: BKDNColor.get(hex: .purple), width: 5)
        self.imgIcon.image     = UIImage(named: "ic_check_h")
        if let st = datas?["status"] as? String{
            if st != "Lunas"{
                BKDNView.borderWithColor(vw: vwCircle, color: UIColor.groupTableViewBackground, width: 5)
                self.imgIcon.image = UIImage(named: "ic_note_h")            }
        }
    }
    
    func setRight(r: [[String]]){
        let a = NSMutableAttributedString()
        for d in r{
            a.append(BString.setAtrRight(data: d))
        }
        
        lblContent.attributedText = a
    }
    
    func setBTN(){
        BKDNView.radius(vw: btnBayar, rad: 20)
    }
    
    @IBAction func bayar(_ sender: Any) {
        self.delegat?.bayar(index: currindex)
    }
}
