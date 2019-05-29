//
//  VWPOPProsesPembiayaan.swift
//  bukadana
//
//  Created by Gaenael on 1/8/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VWPOPProsesPembiayaan: UIViewController {

    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        BKDNView.radius(vw: vwContent, rad: 8)
        BKDNView.radius(vw: btnSubmit, rad: 14)
        // Do any additional setup after loading the view.
    }

    @IBAction func actionSubmit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
