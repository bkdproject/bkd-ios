//
//  BKDNFont.swift
//  bukadana
//
//  Created by Gaenael on 1/6/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

struct BKDNFont {
    
    enum fontName:String{
        case Montserrat = "Montserrat",
             WorkSans   = "WorkSans"
    }
    
    enum fontType:String {
        case Light    = "Light",
             Regular  = "Regular",
             Medium   = "Medium",
             Semibold = "SemiBold",
             Bold     = "Bold"
    }
    
    static func getFont(name: fontName, type: fontType, size: CGFloat) -> UIFont?{
        return UIFont(name: "\(name.rawValue)-\(type.rawValue)", size: size)
    }
    
    static func getFontStr(name: fontName, type: fontType) -> String{
        return "\(name.rawValue)-\(type.rawValue)"
    }
}
