//
//  BKDNString.swift
//  bukadana
//
//  Created by PT SPRINT ASIA on 01/03/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class BString: NSObject {
    
    static func setAtrNotePembayaran() -> NSMutableAttributedString{
        let formattedString = NSMutableAttributedString()
        formattedString
            .itemNote("* Catatan: Saldo anda akan dikurangi tagihan anda jika menekan tombol submit. Jika saldo anda tidak tercukupi silahkan lakukan ", align: .center)
            .bold("Topup ")
            .itemNote("terlebih dahulu.", align: .center)
        
        return formattedString
    }
    
    func setAtrOTP(s: Int) -> NSMutableAttributedString{
        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("Kirim ulang OTP sekitar")
            .bold(" \(s) ")
            .normal("Detik")
        
        return formattedString
    }
    
    func setAtrCompletedOTP() -> NSMutableAttributedString{
        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("Kirim ulang OTP")
        
        return formattedString
    }
    
    static func setAtrRight(data:[String]) -> NSMutableAttributedString{
        let formattedString = NSMutableAttributedString()
        formattedString
            .itemTitle(data[0], align: .left)
            .itemContent(data[1], align: .left)
        
        return formattedString
    }
    
    static func setAtrLeft(data:[String]) -> NSMutableAttributedString{
        let formattedString = NSMutableAttributedString()
        formattedString
            .itemTitle(data[0], align: .right)
            .itemContent(data[1], align: .right)
        
        return formattedString
    }
}


extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Helvetica-Bold", size: 12)!]
        let bold = NSMutableAttributedString(string:text, attributes: attrs)
        append(bold)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Helvetica", size: 12)!]
        let normal = NSMutableAttributedString(string:text, attributes: attrs)
        append(normal)
        
        return self
    }
    
    @discardableResult func itemNote(_ text: String, align: NSTextAlignment) -> NSMutableAttributedString {
        let color = UIColor.darkGray
        // create the attributed colour
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.alignment = align
        
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: BKDNFont.getFontStr(name: .Montserrat, type: .Regular), size: 12)!, .foregroundColor : color, .paragraphStyle: paragraphStyle]
        let bold = NSMutableAttributedString(string:text, attributes: attrs)
        append(bold)
        
        return self
    }
    
    @discardableResult func itemTitle(_ text: String, align: NSTextAlignment) -> NSMutableAttributedString {
        let color = UIColor.darkGray
        // create the attributed colour
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.minimumLineHeight = 20 // Whatever line spacing you want in points
        paragraphStyle.alignment = align
        
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: BKDNFont.getFontStr(name: .Montserrat, type: .Bold), size: 12)!, .foregroundColor : color, .paragraphStyle: paragraphStyle]
        let bold = NSMutableAttributedString(string:text, attributes: attrs)
        append(bold)
        
        return self
    }
    
    @discardableResult func itemContent(_ text: String, align: NSTextAlignment) -> NSMutableAttributedString {
        let color = UIColor.darkGray
        // create the attributed colour
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.minimumLineHeight = 20 // Whatever line spacing you want in points
        paragraphStyle.alignment = align
        
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: BKDNFont.getFontStr(name: .WorkSans, type: .Regular), size: 14)!, .foregroundColor : color, .paragraphStyle: paragraphStyle]
        let bold = NSMutableAttributedString(string:text, attributes: attrs)
        append(bold)
        
        return self
    }
}


