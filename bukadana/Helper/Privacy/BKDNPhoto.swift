//
//  BKDNPhoto.swift
//  bukadana
//
//  Created by Gaenael on 3/2/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol BPPhotoDelegate {
    func getImage()
}

class BPPhoto: NSObject {
    let galleryPicker = UIImagePickerController()
    
    override init() {
        super.init()
    }
    
    func openCamera(vc: UIViewController) {
        galleryPicker.sourceType = .camera
        vc.present(galleryPicker, animated: true)
    }
    
    func openPhotoLibrary(vc: UIViewController) {
        galleryPicker.sourceType = .photoLibrary
        vc.present(galleryPicker, animated: true)
    }
}
