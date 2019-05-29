//
//  VCBoarding.swift
//  bukadana
//
//  Created by Gaenael on 12/29/18.
//  Copyright © 2018 Gaenael. All rights reserved.
//

import UIKit

class VCBoarding: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var lgImage: UIImageView!
    
    @IBOutlet weak var btnMasuk: UIButton!
    @IBOutlet weak var btnDaftar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    
    func configUI(){
        bgImage.image = UIImage(named: "bg")
        BKDNView.radius(vw: [btnMasuk, btnDaftar], rad: 20)
        BKDNView.borderWithColor(vw: btnDaftar, color: .white)
        
        btnMasuk.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        btnDaftar.addTarget(self, action: #selector(toRegister), for: .touchUpInside)
    }
    
    @objc func toLogin(){
        self.performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    @objc func toRegister(){
        self.performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let iden = segue.identifier
        switch iden {
        case "toLogin":
            let vc = segue.destination as? VCLogin
            vc?.delegate = self
        default:
            break
        }
    }
}

extension VCBoarding: VCLoginDelegate{
    func toDaftar() {
        toRegister()
    }
}
