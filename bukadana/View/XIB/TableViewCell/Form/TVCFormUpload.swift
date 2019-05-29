//
//  TVCFormUpload.swift
//  bukadana
//
//  Created by Gaenael on 1/20/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import AlamofireImage

protocol TVCFormUploadDelegate {
    func clickCamera(ind: IndexPath)
    func changeImage(ind: IndexPath)
    func updateImage(ind: IndexPath, img: UIImage?)
}

class TVCFormUpload: UITableViewCell {
    
    var delegat: TVCFormUploadDelegate?
    
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwCamera: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblPlaceholder: UILabel!
    @IBOutlet weak var aloading: UIActivityIndicatorView!
    @IBOutlet weak var lblProcess: UILabel!
    
    var index = IndexPath()
    var isLoadImage = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
        BKDNView.radius(vw: vwCamera, rad: 8)
        let tap = UITapGestureRecognizer(target: self, action: #selector(openCam))
        vwContent.addGestureRecognizer(tap)
        
        let tapChange = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapChange)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func styleUpload2(form: MFormText){
        lblTitle.text = form.title
        imgView.backgroundColor = .white
        if let img = form.image{
            vwCamera.isHidden       = true
            lblPlaceholder.isHidden = true
            imgView.isHidden        = false
            imgView.image           = img
        }
        else{
            if form.content != ""{
                BKDNLog.log(str: form.content, types: .other)
                imgView.backgroundColor = .groupTableViewBackground
                vwCamera.isHidden       = true
                lblPlaceholder.isHidden = true
                aloading.startAnimating()
                lblProcess.isHidden = false
                imgView.af_setImage(withURL: URL(string: form.content)!) { (img) in
                    self.aloading.stopAnimating()
                    self.lblProcess.isHidden = true
                    self.delegat?.updateImage(ind: self.index, img: self.imgView.image)
                }
            }
            else{
                vwCamera.isHidden       = false
                lblPlaceholder.isHidden = false
                imgView.isHidden        = true
                imgView.image           = nil
            }
        }
    }
    
//    func styleUpload(form: MFormText){
//        isLoadImage = false
//        lblTitle.text = form.title
//        if let img = form.image{
//            print("1")
//            vwCamera.isHidden       = true
//            lblPlaceholder.isHidden = true
//            imgView.isHidden        = false
//            imgView.image           = img
//        }
//        else{
//            if form.content != ""{
//                if isLoadImage{
//                    print("2")
//                    vwCamera.isHidden       = false
//                    lblPlaceholder.isHidden = false
//                    imgView.isHidden        = true
//                    imgView.image           = nil
//                }
//                else{
//                    print("3")
//                    vwCamera.isHidden       = false
//                    lblPlaceholder.isHidden = false
//                    imgView.isHidden        = false
//                    imgView.af_setImage(withURL: URL(string: form.content)!) { (img) in
//                        if form.image == nil{
//                            self.isLoadImage = true
//                            self.vwCamera.isHidden       = true
//                            self.lblPlaceholder.isHidden = true
//                            self.delegat?.updateImage(ind: self.index, img: self.imgView.image)
//                        }
//                    }
//                }
//                
//            }
//            else{
//                print("4")
//                vwCamera.isHidden       = false
//                lblPlaceholder.isHidden = false
//                imgView.isHidden        = true
//                imgView.image           = nil
//            }
//        }
//    }
    
    @objc func openCam(){
        self.delegat?.clickCamera(ind: self.index)
    }
    
    @objc func changeImage(){
        self.delegat?.changeImage(ind: self.index)
    }
}


