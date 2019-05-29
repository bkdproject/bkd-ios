//
//  CVCFeature.swift
//  bukadana
//
//  Created by Gaenael on 1/7/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class CVCFeature: UICollectionViewCell {

    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var icImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data: [String:String]){
        lblTitle.text = data["title"]
        lblDesc.text  = data["desc"]
        bgImg.image   = UIImage(named: "\(data["bg_im"] ?? "")")
        icImg.image   = UIImage(named: "\(data["ic_im"] ?? "")")
    }
}
