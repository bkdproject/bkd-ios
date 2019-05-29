//
//  TVCTD.swift
//  bukadana
//
//  Created by Gaenael on 3/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class TVCTD: UITableViewCell {

    @IBOutlet weak var lblRight: UILabel!
    @IBOutlet weak var lblLeft: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(right: [[String]], left: [[String]]){
        lblRight.attributedText = getRight(r: right)
        lblLeft.attributedText  = getLeft(l: left)
    }
    
    
    func getRight(r: [[String]]) -> NSMutableAttributedString{
        let a = NSMutableAttributedString()
        for d in r{
            a.append(BString.setAtrRight(data: d))
        }
        return a
    }
    
    func getLeft(l: [[String]]) -> NSMutableAttributedString{
        let a = NSMutableAttributedString()
        for d in l{
            a.append(BString.setAtrLeft(data: d))
        }
        return a
    }
}
