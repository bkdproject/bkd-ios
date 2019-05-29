//
//  TVCTopUp.swift
//  bukadana
//
//  Created by Gaenael on 2/15/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class TVCTopUp: UITableViewCell {

    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configHeader(){
        BKDNView.radius(vw: vwContent, rad: 8)
        BKDNView.radius(vw: imgView, rad: 29)
        
        var frames        = vwContent.frame
        frames.origin.y   = 0
        frames.origin.x   = 0
        frames.size.width = BKDNFrame.getWidht() - (16 * 2)
        
        BKDNView.setShadow3(vw: vwContent, bounds: frames)
    }
}
