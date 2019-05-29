//
//  BKDNColor.swift
//  bukadana
//
//  Created by Gaenael on 12/29/18.
//  Copyright © 2018 Gaenael. All rights reserved.
//

import UIKit

class BKDNColor: NSObject {
    enum hexColor:String {
        case green   = "#B3D236",
             blue    = "#11A2BF",
             purple  = "#655ee0",
             yellow  = "#FFFACD"
    }
    
    enum Colors:String {
        case red1      = "#C0392B",   // 1 Young
        red2      = "#E74C3C",   // 2 Old
        purple1   = "#9B59B6",
        purple2   = "#8E44AD",
        blue1     = "#2980B9",
        blue2     = "#3498DB",
        tosca1    = "#1ABC9C",
        tosca2    = "#16A085",
        green1    = "#27AE60",
        green2    = "#2ECC71",
        yellow1   = "#F1C40F",
        yellow2   = "#F39C12",
        orange1   = "#E67E22",
        orange2   = "#D35400",
        white1    = "#ECF0F1",
        white2    = "#BDC3C7",
        gray1     = "#95A5A6",
        gray2     = "#7F8C8D",
        black1    = "#34495E",
        black2    = "#2C3E50"
    }
    
    static func get(hex: hexColor? = nil, hexColors: Colors? = nil, name: String? = "")->UIColor{
        var hx = ""
        if hex != nil{
            hx = hex?.rawValue ?? ""
        }
        else if hexColors != nil{
            hx = hexColors?.rawValue ?? ""
        }
        else{
            hx = name ?? ""
        }
        
        var cString:String = hx.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func getHex(hex: Colors) -> String{
        return hex.rawValue
    }
}
