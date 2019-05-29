//
//  BKDNImage.swift
//  bukadana
//
//  Created by Gaenael on 12/29/18.
//  Copyright © 2018 Gaenael. All rights reserved.
//

import UIKit

struct BKDNImage {
    static func changeImageFrom(name: String = "") -> UIImage{
        let img = UIImage(named: name)!
        return changeImage(image: img)
    }
    static func changeImageFrom(img: UIImage) -> UIImage{
        return changeImage(image: img)
    }
    static func changeImageFrom(imgView: UIImageView, color:UIColor){
        imgView.image     = changeImage(image: imgView.image ?? UIImage())
        imgView.tintColor = color
    }
    
    //Set Private
    private static func changeImage(image: UIImage) -> UIImage{
        if image.size.width > 0{
            return image.withRenderingMode(.alwaysTemplate)
        }
        else{
            return image
        }
    }
}
