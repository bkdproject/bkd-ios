//
//  BKDNVHeader.swift
//  bukadana
//
//  Created by Gaenael on 12/29/18.
//  Copyright © 2018 Gaenael. All rights reserved.
//

import UIKit

class BKDNVHeader: UIView {
    var button1: UIButton = UIButton()
    
    var label1 : UILabel      = UILabel()
    var label2 : UILabel      = UILabel()
    var image  : UIImageView  = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func addBackButton(){
        button1   = UIButton.init(type: .system)
        button1.frame =  CGRect(x: 12, y: 24, width: 16, height: 32)
        button1.setImage(UIImage(named: "ic_back"), for: .normal)
        button1.tintColor = .white
        self.addSubview(button1)
    }
    
    func addCloseButton(){
        button1   = UIButton.init(type: .system)
        button1.frame =  CGRect(x: 12, y: 24, width: 32, height: 32)
        button1.setImage(UIImage(named: "ic_close"), for: .normal)
        button1.tintColor = .white
        self.addSubview(button1)
    }
    
    func setStyle1(title: String, desc: String){
        label1               = UILabel.init(frame: CGRect(x: 0, y: 64, width: BKDNFrame.getWidht(), height: 22))
        label1.font          = BKDNFont.getFont(name: .Montserrat, type: .Bold, size: 20)
        print(label1.font)
        label1.text          = title
        label1.textAlignment = .center
        label1.textColor     = .white
        self.addSubview(label1)
        
        label2               = UILabel.init(frame: CGRect(x: 0, y: 86 + 4, width: BKDNFrame.getWidht(), height: 16))
        label2.font          = BKDNFont.getFont(name: .Montserrat, type: .Light, size: 14)
        label2.text          = desc
        label2.textAlignment = .center
        label2.textColor     = .white
        self.addSubview(label2)
    }
    
    func setStyle2(title: String){
        label1               = UILabel.init(frame: CGRect(x: 16, y: 78, width: BKDNFrame.getWidht() - 32, height: 22))
        label1.font          = BKDNFont.getFont(name: .Montserrat, type: .Bold, size: 20)
        label1.text          = title
        label1.textAlignment = .left
        label1.textColor     = .white
        self.addSubview(label1)
    }
    
     func  setStyle3(title: String, desc: String){
        button1 = UIButton(type: .system)
        button1.frame = CGRect(x: 13, y: 32, width: 16, height: 31)
        button1.setImage(UIImage(named: "ic_back"), for: .normal)
        button1.tintColor = .white
        self.addSubview(button1)
        
        label1               = UILabel.init(frame: CGRect(x: 45, y: 28, width: BKDNFrame.getWidht() - 32, height: 22))
        label1.font          = BKDNFont.getFont(name: .Montserrat, type: .Bold, size: 20)
        label1.text          = title
        label1.textAlignment = .left
        label1.textColor     = .white
        self.addSubview(label1)
        
        label2               = UILabel.init(frame: CGRect(x: 45, y: 46 + 4, width: BKDNFrame.getWidht(), height: 16))
        label2.font          = BKDNFont.getFont(name: .Montserrat, type: .Light, size: 12)
        label2.text          = desc
        label2.textAlignment = .left
        label2.textColor     = .white
        self.addSubview(label2)
    }
    
    func setStyle4(title: String, desc: String){
        label1               = UILabel.init(frame: CGRect(x: 13, y: 28, width: BKDNFrame.getWidht() - 32, height: 22))
        label1.font          = BKDNFont.getFont(name: .Montserrat, type: .Bold, size: 20)
        label1.text          = title
        label1.textAlignment = .left
        label1.textColor     = .white
        self.addSubview(label1)
        
        label2               = UILabel.init(frame: CGRect(x: 13, y: 46 + 4, width: BKDNFrame.getWidht(), height: 16))
        label2.font          = BKDNFont.getFont(name: .Montserrat, type: .Light, size: 12)
        label2.text          = desc
        label2.textAlignment = .left
        label2.textColor     = .white
        self.addSubview(label2)
    }
    
    func setStyle4WithBack(title: String, desc: String){
        button1 = UIButton(type: .system)
        button1.frame = CGRect(x: 13, y: 32, width: 16, height: 24)
        button1.setImage(UIImage(named: "ic_back"), for: .normal)
        button1.tintColor = .white
        self.addSubview(button1)
        
        label1               = UILabel.init(frame: CGRect(x: 8 + 29, y: 34, width: BKDNFrame.getWidht() - 32, height: 22))
        label1.font          = BKDNFont.getFont(name: .Montserrat, type: .Bold, size: 20)
        label1.text          = title
        label1.textAlignment = .left
        label1.textColor     = .white
        self.addSubview(label1)
    }
    
    func setStyleForm(title: String, desc: String){
        
        button1 = UIButton(type: .system)
        button1.frame = CGRect(x: 20, y: 32, width: 16, height: 31)
        button1.setImage(UIImage(named: "ic_back"), for: .normal)
        button1.tintColor = .white
        self.addSubview(button1)
        
        label1               = UILabel.init(frame: CGRect(x: 40 + 20, y: 36, width: BKDNFrame.getWidht() - 32, height: 22))
        label1.font          = BKDNFont.getFont(name: .Montserrat, type: .Bold, size: 20)
        label1.text          = title
        label1.textAlignment = .left
        label1.textColor     = .white
        self.addSubview(label1)
        
        label2               = UILabel.init(frame: CGRect(x: 20, y: 61 + 16, width: BKDNFrame.getWidht() - 64, height: 16))
        label2.font          = BKDNFont.getFont(name: .Montserrat, type: .Regular, size: 13)
        label2.text          = desc
        label2.textAlignment = .left
        label2.textColor     = .white
        label2.numberOfLines = 0
        label2.sizeToFit()
        self.addSubview(label2)
    }
    
    func setProfileForm(title: String, desc: String){
        
        button1 = UIButton(type: .system)
        button1.frame = CGRect(x: 20, y: 32, width: 16, height: 31)
        button1.setImage(UIImage(named: "ic_back"), for: .normal)
        button1.tintColor = .white
        self.addSubview(button1)
        
        label1               = UILabel.init(frame: CGRect(x: 40 + 10, y: 26, width: BKDNFrame.getWidht() - 32, height: 22))
        label1.font          = BKDNFont.getFont(name: .Montserrat, type: .Bold, size: 20)
        label1.text          = title
        label1.textAlignment = .left
        label1.textColor     = .white
        self.addSubview(label1)
        
        label2               = UILabel.init(frame: CGRect(x: 40 + 10, y: 50, width: BKDNFrame.getWidht() - 64, height: 16))
        label2.font          = BKDNFont.getFont(name: .Montserrat, type: .Regular, size: 13)
        label2.text          = desc
        label2.textAlignment = .left
        label2.textColor     = .white
        label2.numberOfLines = 0
        label2.sizeToFit()
        self.addSubview(label2)
        
        image = UIImageView.init(frame: CGRect(x: (BKDNFrame.getWidht() / 2) - 30, y: 84, width: 60, height: 60))
        image.image = UIImage(named: "ico_profilephoto")
        image.backgroundColor = .clear
        BKDNView.radius(vw: image, rad: 30)
        self.addSubview(image)
        
        let imgFrame = image.frame
        let label = UILabel.init(frame: CGRect(x: 40 + 10, y: imgFrame.size.height + imgFrame.origin.y + 8, width: BKDNFrame.getWidht() - 100, height: 16))
        label.font          = BKDNFont.getFont(name: .Montserrat, type: .Bold, size: 12)
        
        let tipe = Int(BUserKeyModel.getType())
        switch tipe {
        case 1:
            label.text = "Member Pinjaman"
        default:
            label.text = "Member Pendana"
        }
        
        label.textColor = .white
        label.textAlignment = .center
        self.addSubview(label)
    }
}
