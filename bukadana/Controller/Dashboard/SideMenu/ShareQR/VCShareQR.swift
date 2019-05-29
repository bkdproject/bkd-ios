//
//  VCShareQR.swift
//  bukadana
//
//  Created by Gaenael on 2/22/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import QRCode

class VCShareQR: UIViewController {
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var vwHeader: BKDNVHeader!
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var imgQR: UIImageView!
    
    @IBOutlet weak var vcQR: UIView!
    var qrcodeImage: CIImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
    }
    
    func configUI(){
        bgImg.image = UIImage(named: "bg")
        vwHeader.setStyle4WithBack(title: "QR Code Member", desc: "")
        vwHeader.button1.addTarget(self, action: #selector(actionButton1), for: .touchUpInside)
        BKDNView.radius(vw: vcQR, rad: 8)
        
        let ids     = BKDNUserDataModel.getData().member_id ?? ""
        imgQR.image = generateQRCode(from: ids)
        lblID.text = ids
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("M", forKey: "inputCorrectionLevel")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    @objc func actionButton1(){
        self.dismiss(animated: true, completion: nil)
    }

}
