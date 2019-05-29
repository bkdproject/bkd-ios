//
//  VCPopWebview.swift
//  bukadana
//
//  Created by Gaenael on 2/24/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol VCPopWebviewDelegate{
    func success()
}

class VCPopWebview: UIViewController {

    var delegate: VCPopWebviewDelegate?
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var url = ""
    
    var urlD = "transaction_status=pending"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("url == \(url )")
        webView.delegate = self
        webView.isUserInteractionEnabled = true
        webView.loadRequest(URLRequest(url: URL(string: self.url)!))
    }
    
    @IBAction func actionDone(_ sender: Any) {
        let alert = BKDNAlert.showAlertYesNo(title: "Info", msg: "Apakah anda ingin membatalkan transaksi", actionYes: { (_) in
            self.dismiss(animated: true, completion: nil)
        }) { (_) in
            //
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension VCPopWebview: UIWebViewDelegate{
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("error == \(error)")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
        let urlString = webView.request?.url?.absoluteString ?? ""
        if urlString.range(of: urlD) != nil{
            self.dismiss(animated: true) {
                self.delegate?.success()
            }
        }
    }
}
