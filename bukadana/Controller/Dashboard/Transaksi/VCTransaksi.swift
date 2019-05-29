//
//  VCTransaksi.swift
//  bukadana
//
//  Created by Gaenael on 2/15/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

class VCTransaksi: UIViewController {

    var model   = ADTList()
    var refresh = BKDNRefreshControl()
    @IBOutlet weak var vwHeader: BKDNVHeader!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgImg: UIImageView!
    
    @IBOutlet weak var vwSearch: UIView!
    
    var arrTransaksi = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config()
    }
    
    func config(){
        tableView.contentInset    = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        vwHeader.setStyle4(title: "Transaksi", desc: "Histori Transaksi Repayment anda")
        BKDNView.registerNibTableView(tblView: tableView, nibName: "TVCTList")
        
        bgImg.image = UIImage(named: "bg")
        
        var frames        = vwSearch.frame
        frames.origin.y   = 0
        frames.origin.x   = 0
        frames.size.width = BKDNFrame.getWidht() - (16 * 2)
        BKDNView.setShadow3(vw: vwSearch, bounds: frames)
        
        refresh.delegate = self
        refresh.addRefresh(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getApi()
    }
    
    @objc func dismiss(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func getApi(){
        model.getData { (data, err) in
            self.refresh.stopAnimation()
            if err == nil{
                self.arrTransaksi = data
                self.tableView.reloadData()
            }
            else{
                let alert = BKDNAlert.showAlertErr(title: "Info", msg: err?.msg ?? "")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailTransaksi"{
            let tag = sender as! Int
            let vc  = segue.destination as! VCTransaksiDetail
            vc.data = arrTransaksi[tag]
        }
    }

}

extension VCTransaksi: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTransaksi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrTransaksi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCTList") as? TVCTList
        cell?.setData(data: data)
        cell?.btnDetail.tag = indexPath.row
        cell?.delegat = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 244
    }
}

extension VCTransaksi: BKDNRefreshControlDelegate{
    func actionRefresh() {
        getApi()
    }
}

extension VCTransaksi: TVCTListDelegate{
    func onClickDetail(tag: Int) {
        self.performSegue(withIdentifier: "toDetailTransaksi", sender: tag)
    }
}
