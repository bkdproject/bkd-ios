//
//  TVCTitle.swift
//  bukadana
//
//  Created by Gaenael on 1/17/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class TVCTitle: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle(title: MFormTitle){
        lblTitle.text = title.title
        lblDesc.text  = title.desc
    }
}

class MFormTitle: NSObject {
    var title : String = ""
    var desc  : String = ""
    
    public init(title: String, desc: String) {
        self.title = title
        self.desc  = desc
    }
}
