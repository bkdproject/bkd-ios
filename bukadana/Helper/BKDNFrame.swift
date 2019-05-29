//
//  BKDNFrame.swift
//  bukadana
//
//  Created by Gaenael on 12/29/18.
//  Copyright © 2018 Gaenael. All rights reserved.
//

import UIKit

struct BKDNFrame {
    static func bounds()->CGRect{
        return UIScreen.main.bounds
    }
    
    static func getHeight()->CGFloat{
        return bounds().height
    }
    
    static func getWidht()->CGFloat{
        return bounds().width
    }
}
