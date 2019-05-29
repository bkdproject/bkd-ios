//
//  CVCOnBoarding.swift
//  bukadana
//
//  Created by Gaenael on 2/10/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import FSPagerView

class CRSOnBoarding: FSPagerViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnLewati: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configView()
    }
    
    func configView(){
        BKDNView.radius(vw: self, rad: 8)
        BKDNView.radius(vw: btnLewati, rad: 18)
        self.backgroundColor = .white
    }
    
    func setData(data: [String:String]){
        lblTitle.text = data["title"]
        lblDesc.text  = data["desc"]
    }
}
