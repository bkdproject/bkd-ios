//
//  BKDNConstraint.swift
//  bukadana
//
//  Created by Gaenael on 1/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BKDNConstraints: NSObject {
    
    enum type{
        case leading,
        top,
        trailing,
        bottom,
        widht,
        height,
        cHor,
        cVer
    }
    
    static func setConstraintReg(types:type, typesTo:NSLayoutConstraint.Attribute = .leading, cons:Int, item:UIView, toItem:UIView?=nil)->NSLayoutConstraint{
        switch types {
        case .leading:
            return getLeading(item: item, toItem: toItem, cons: cons, typesTo: typesTo)
        case .top:
            return getTop(item: item, toItem: toItem, cons: cons, typesTo: typesTo)
        case .trailing:
            return getTrailing(item: item, toItem: toItem, cons: cons, typesTo: typesTo)
        case .bottom:
            return getBottom(item: item, toItem: toItem, cons: cons, typesTo: typesTo)
        case .height:
            return getHeight(item: item, cons: cons)
        case .widht:
            return getWidth(item: item, cons: cons)
        case .cHor:
            return getCenterHorizontal(item: item, toItem: toItem, cons: cons)
        case .cVer:
            return getCenterVertical(item: item, toItem: toItem, cons: cons)
        }
    }
    
    //Leading
    private static func getLeading(item:UIView, toItem:UIView?=nil, cons:Int, typesTo:NSLayoutConstraint.Attribute)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: .leading, relatedBy: .equal, toItem: toItem, attribute: typesTo, multiplier: 1, constant: CGFloat(cons))
    }
    
    //Top
    private static func getTop(item:UIView, toItem:UIView?=nil, cons:Int, typesTo:NSLayoutConstraint.Attribute)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: typesTo, multiplier: 1, constant: CGFloat(cons))
    }
    
    //Trailing
    private static func getTrailing(item:UIView, toItem:UIView?=nil, cons:Int, typesTo:NSLayoutConstraint.Attribute)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: .trailing, relatedBy: .equal, toItem: toItem, attribute: typesTo, multiplier: 1, constant: CGFloat(cons))
    }
    
    //Bottom
    private static func getBottom(item:UIView, toItem:UIView?=nil, cons:Int, typesTo:NSLayoutConstraint.Attribute)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: typesTo, multiplier: 1, constant: CGFloat(cons))
    }
    
    //Height
    private static func getHeight(item:UIView, toItem:UIView?=nil, cons:Int)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal, toItem: toItem, attribute: .height, multiplier: 1, constant: CGFloat(cons))
    }
    
    //Width
    private static func getWidth(item:UIView, toItem:UIView?=nil, cons:Int)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: toItem, attribute: .width, multiplier: 1, constant: CGFloat(cons))
    }
    
    //cHorizontal
    private static func getCenterHorizontal(item:UIView, toItem:UIView?=nil, cons:Int)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: toItem, attribute: .centerX, multiplier: 1, constant: CGFloat(cons))
    }
    
    //cVertical
    private static func getCenterVertical(item:UIView, toItem:UIView?=nil, cons:Int)->NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: .centerY, relatedBy: .equal, toItem: toItem, attribute: .centerY, multiplier: 1, constant: CGFloat(cons))
    }
}

