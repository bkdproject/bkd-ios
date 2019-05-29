//
//  VHandle.swift
//  bukadana
//
//  Created by Gaenael on 3/3/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

public enum Handle: String {
    case loading = "VLoading"
}

protocol VHandleDelegate {
    func refresh_action()
}

class VHandle: UIView {
    var delegat : VHandleDelegate?
    @IBOutlet var vwContent: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var blur: UIVisualEffectView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadViewFromNib(nib: Handle) {
        let nib = UINib(nibName: nib.rawValue, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        self.alpha = 0
        
        self.addSubview(view);
    }
    
    func setupLoading(){
        self.vwContent.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        BKDNView.radius(vw: blur, rad: 8)
    }
    
    //Loading
    func startLoading(){
        self.fadeIn()
    }
    func stopLoading(){
        self.fadeOut()
    }
    
    @IBAction func refresh(_ sender: Any) {
        delegat?.refresh_action()
    }
}

public extension UIView {
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(duration: TimeInterval = 0.2) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(duration: TimeInterval = 0.2) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}
