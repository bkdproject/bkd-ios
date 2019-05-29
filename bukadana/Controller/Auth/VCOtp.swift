//
//  VCOtp.swift
//  bukadana
//
//  Created by Gaenael on 12/30/18.
//  Copyright © 2018 Gaenael. All rights reserved.
//

import UIKit
import SideMenuSwift
import AccountKit

class VCOtp: UIViewController {

    @IBOutlet weak var vwHeader: BKDNVHeader!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var _accountKit: AKFAccountKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if _accountKit?.currentAccessToken != nil {
            // if the user is already logged in, go to the main screen
            // ...
        }
        else {
            // Show the login screen
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginWithPhone()
    }
    
    func configUI(){
        bgImage.image = UIImage(named: "bg")
        vwHeader.addCloseButton()
        vwHeader.setStyle2(title: "Verify Your Mobile")
        vwHeader.button1.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        BKDNView.registerNibTableView(tblView: self.tableView, nibName: "TVCOtp")
        tableView.delegate       = self
        tableView.dataSource     = self
        tableView.separatorStyle = .none
        
        if _accountKit == nil {
            _accountKit = AKFAccountKit(responseType: .accessToken)
        }
    }
    
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension VCOtp: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCOtp") as? TVCOtp
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 208
    }
}

extension VCOtp: TVCOtpDelegate{
    func verifyOtp() {
        self.performSegue(withIdentifier: "toDashboard", sender: nil)
        /*let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "SideMenu") as? SideMenuController
        let nav = UINavigationController(rootViewController: homeViewController)
        appdelegate.window!.rootViewController = homeViewController*/
    }
}

extension VCOtp: AKFViewControllerDelegate{
    func loginWithPhone(){
        let inputState = UUID().uuidString
        let number = AKFPhoneNumber.init(countryCode: "+62", phoneNumber: "85717856321")
        let vc = (_accountKit?.viewControllerForPhoneLogin(with: number, state: inputState))!
        vc.enableSendToFacebook = true
        self.prepareLoginViewController(loginViewController: vc)
        self.present(vc, animated: true, completion: nil)
    }
    
    func prepareLoginViewController(loginViewController: AKFViewController) {
        loginViewController.delegate = self
        //UI Theming - Optional
        loginViewController.uiManager = AKFSkinManager(skinType: .classic, primaryColor: UIColor.blue)
    }
    
    private func viewController(viewController: UIViewController!, didCompleteLoginWithAccessToken accessToken: AKFAccessToken!, state: String!) {
        print("did complete login with access token \(accessToken.tokenString) state \(String(describing: state))")
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print(code)
        print(state)
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didFailWithError error: Error!) {
        // ... implement appropriate error handling ...
        print("\(String(describing: viewController)) did fail with error: \(error.localizedDescription)")
    }
    
    func viewControllerDidCancel(_ viewController: (UIViewController & AKFViewController)!) {
        // ... handle user cancellation of the login process ...
    }
}
