//
//  MenuViewController.swift
//  SideMenuExample
//
//  Created by kukushi on 11/02/2018.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit
import SideMenuSwift

class Preferences {
    static let shared = Preferences()
    var enableTransitionAnimation = false
}

class MenuViewController: UIViewController {
    var isDarkModeEnabled = false
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            
            tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            tableView.contentOffset = CGPoint(x: 0, y: -20)
        }
    }
    @IBOutlet weak var selectionTableViewHeader: UILabel!

    @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!
    private var themeColor = UIColor.clear

    var arrMenu = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isDarkModeEnabled = SideMenuController.preferences.basic.position == .under
        configureView()
        
        BKDNView.registerNibTableView(tblView: self.tableView, nibName: "TVCMenuHeader")
        
        sideMenuController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }

    private func configureView() {
        let type = typeUser(rawValue: BUserKeyModel.getType())!
        arrMenu = getArr(type: type)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.tableView.reloadData()
        let showPlaceTableOnLeft = (SideMenuController.preferences.basic.position == .under) != (SideMenuController.preferences.basic.direction == .right)
        selectionMenuTrailingConstraint.constant = showPlaceTableOnLeft ? SideMenuController.preferences.basic.menuWidth - size.width : 0
        view.layoutIfNeeded()
    }
}

extension MenuViewController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController, animationControllerFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }

    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller will show [\(viewController)]")
    }

    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller did show [\(viewController)]")
    }

    func sideMenuWillHide(_ sideMenu: SideMenuController) {
        print("[Example] Menu will hide")
    }

    func sideMenuDidHide(_ sideMenu: SideMenuController) {
        print("[Example] Menu did hide.")
    }

    func sideMenuWillReveal(_ sideMenu: SideMenuController) {
        print("[Example] Menu will show.")
    }

    func sideMenuDidReveal(_ sideMenu: SideMenuController) {
        print("[Example] Menu did show.")
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + arrMenu.count
    }

    // swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVCMenuHeader", for: indexPath) as! TVCMenuHeader
            cell.configView()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectionCell
            cell.contentView.backgroundColor = .clear
            cell.selectionStyle = .none
            
            cell.titleLabel?.text = arrMenu[indexPath.row - 1]
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            let title = arrMenu[indexPath.row - 1]
            
            switch title {
            case "Ubah Profile":
                let profile = UIStoryboard.init(name: "Profile", bundle: nil)
                self.pushView(vc: profile.instantiateViewController(withIdentifier: "VCMenuProfile"))
                sideMenuController?.hideMenu()
            case "Daftar Peminjam":
                if checkUserPersentase(){
                    if BKDNUserDataModel.getCekBiaya(){
                        let profile = UIStoryboard.init(name: "Profile", bundle: nil)
                        self.pushView(vc: profile.instantiateViewController(withIdentifier: "NavDetailPinjaman"))
                        sideMenuController?.hideMenu()
                    }
                    else{
                        let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Member sebagai pendana belum aktif")
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else{
                    let alert = BKDNAlert.showAlertErr(title: "Info", msg: "Silahkan lengkapi profile anda terlebih dahulu")
                    self.present(alert, animated: true, completion: nil)
                }
            case "Rekening Koran":
                let profile = UIStoryboard.init(name: "Profile", bundle: nil)
                self.pushView(vc: profile.instantiateViewController(withIdentifier: "VCRekKoran"))
                sideMenuController?.hideMenu()
            case "QR Code":
                let profile = UIStoryboard.init(name: "Profile", bundle: nil)
                self.pushView(vc: profile.instantiateViewController(withIdentifier: "VCShareQR"))
                sideMenuController?.hideMenu()
            case "Keluar":
                let alert = BKDNAlert.showAlertLogout { (_) in
                    BUserKeyModel.logout()
                    self.changeRoot()
                }
                self.present(alert, animated: true, completion: nil)
            default:
                break
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 230
        default:
            return 44
        }
    }
}

class SelectionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

extension MenuViewController{
    private func changeRoot(){
        let vc = BKDNController.getControllerFrom(storyoard: "Auth", identifier: "NavAuth") as! UINavigationController
        BKDNController.changeRoot(vc: vc)
    }
    
    private func pushView(vc: UIViewController){
        let app = BKDNController.getAppDelegate()
        let nav = app.window?.rootViewController as? SideMenuController
        
        nav?.present(vc, animated: true, completion: nil)
    }
    
    
    private func getArr(type:typeUser) -> [String]{
        switch type {
        case .peminjam:
            return getArrPeminjam()
        default:
            return getArrPendana()
        }
    }
    
    private func checkUserPersentase() -> Bool{
        let userdata  = BKDNUserDataModel.getData()
        let strProg  = userdata.peringkat_pengguna_persentase
        return strProg == "100"
    }
    
    private func getArrPeminjam() -> [String]{
        return ["Ubah Profile",  "Rekening Koran", "QR Code", "Keluar"]
    }
    
    private func getArrPendana() -> [String]{
        return ["Ubah Profile", "Daftar Peminjam", "Rekening Koran", "QR Code", "Keluar"]
    }
}
