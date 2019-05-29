//
//  BKDNView.swift
//  bukadana
//
//  Created by Gaenael on 12/29/18.
//  Copyright © 2018 Gaenael. All rights reserved.
//

import UIKit

struct BKDNView {
    static func radius(vw: UIView, rad: CGFloat){
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius  = rad
    }
    
    static func radius(vw: [UIView], rad: CGFloat){
        for v in vw {
            v.layer.masksToBounds = true
            v.layer.cornerRadius  = rad
        }
    }
    
    static func border(vw: UIView){
        vw.layer.borderWidth   = 0.5
        vw.layer.borderColor   = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
    static func borderWithColor(vw: UIView, color: UIColor){
        vw.layer.borderWidth   = 1
        vw.layer.borderColor   = color.cgColor
    }
    
    static func borderWithColor(vw: UIView, color: UIColor, width: CGFloat){
        vw.layer.borderWidth   = width
        vw.layer.borderColor   = color.cgColor
    }
    
    static func registerNibTableView(tblView: UITableView, nibName: String){
        let nib = UINib(nibName: nibName, bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: nibName)
    }
    
    static func registerNibCollectionView(clView: UICollectionView, nibName: String){
        let nib = UINib(nibName: nibName, bundle: nil)
        clView.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    static func setShadow3(vw:UIView, bounds: CGRect, scale: Bool = true){
        
        vw.layer.masksToBounds      = false
        vw.layer.shadowColor        = UIColor.black.cgColor
        vw.layer.shadowOpacity      = 0.2
        vw.layer.shadowOffset       = CGSize(width: 0, height: 0)
        vw.layer.shadowRadius       = 4
        vw.layer.cornerRadius       = 4
        vw.layer.shadowPath         = UIBezierPath(rect: bounds).cgPath
        vw.layer.shouldRasterize    = true
        vw.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
