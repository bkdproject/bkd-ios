//
//  TVCFormText.swift
//  bukadana
//
//  Created by Gaenael on 1/15/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCFormTextDelegate {
    func changeText(str: String, ind: IndexPath)
}

class TVCFormText: UITableViewCell {
    
    var delegate: TVCFormTextDelegate?
    
    @IBOutlet weak var vwIcon: UIView!
    @IBOutlet weak var vwText: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtField: BKDNTextField!
    
    @IBOutlet weak var lblPlaceholder: UILabel!
    @IBOutlet weak var txtView: UITextView!
    
    var index = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func styleText(form: MFormText){
        vwText.backgroundColor = .clear
        BKDNView.radius(vw: vwText, rad: 4)
        BKDNView.border(vw: vwText)
        
        lblTitle.text          = form.title
        txtField.placeholder   = form.placeholder
        txtField.text          = form.content
        txtField.delegat       = self
        vwIcon.backgroundColor = .white
        imgIcon.alpha = 0
        
        txtField.addTarget(self, action: #selector(changeText), for: .editingChanged)
        
        switch form.style {
        case .dropdown:
            styleDropdown()
        case .calendar:
            styleCalendar()
        default:
            break
        }
    }
    
    func styleTextView(form: MFormText){
        BKDNView.radius(vw: txtView, rad: 4)
        BKDNView.border(vw: txtView)
        lblTitle.text = form.title
        lblPlaceholder.text = form.placeholder
        txtView.text = form.content
        txtView.delegate = self
        lblPlaceholder.isHidden = (txtView.text.count > 0)
    }
    
    private func styleDropdown(){
        vwIcon.backgroundColor = .groupTableViewBackground
        imgIcon.alpha = 1
        imgIcon.image = UIImage(named: "ic_dropdown")
    }
    
    private func styleCalendar(){
        vwIcon.backgroundColor = .groupTableViewBackground
        imgIcon.alpha = 1
        imgIcon.image = UIImage(named: "ic_calendar")
    }
    
    @objc func changeText(){
        self.delegate?.changeText(str: txtField.text ?? "", ind: self.index)
    }
}

extension TVCFormText: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceholder.isHidden = (textView.text.count > 0)
        self.delegate?.changeText(str: textView.text, ind: self.index)
    }
}

extension TVCFormText: BKDNTextFieldDelegate{
    func didSelect(name: String) {
        self.delegate?.changeText(str: name, ind: self.index)
    }
}

enum styleText: Int {
    case text,
         textView,
         dropdown,
         calendar,
         upload
}

class MFormText: NSObject {
    var title       : String = ""
    var placeholder : String = ""
    var content     : String = ""
    var style       : styleText = .text
    var image       : UIImage?  = nil
    
    public init(title: String, placeholder: String, content: String? = "", style: styleText) {
        self.title       = title
        self.placeholder = placeholder
        self.style       = style
        self.content     = content ?? ""
        self.image       = nil
    }
    
    func setContent(con: String){
        self.content = con
    }
    
    func setImg(ig: UIImage?){
        self.image   = ig
        self.content = ""
    }
}
