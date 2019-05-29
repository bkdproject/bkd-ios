//
//  TVCOtp.swift
//  bukadana
//
//  Created by Gaenael on 1/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCOtpDelegate {
    func verifyOtp()
}

class TVCOtp: UITableViewCell {

    var delegate: TVCOtpDelegate?
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var txtOtp: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
//        self.txtOtp.becomeFirstResponder()
        self.txtOtp.delegate = self
        config()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(){
        BKDNView.radius(vw: self.btnVerify, rad: 22)
    }
    
    @IBAction func ActionVerifyOtp(_ sender: Any) {
        delegate?.verifyOtp()
    }
}

extension TVCOtp: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
