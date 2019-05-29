//
//  MFormProfile.swift
//  bukadana
//
//  Created by Gaenael on 2/13/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class MFormProfile: NSObject {
    var title        : String = ""
    var placeholder  : String = ""
    var content      : String = ""
    
    public init(title:String, ph: String, content: String){
        self.title       = title
        self.placeholder = ph
        self.content     = content
    }
}
