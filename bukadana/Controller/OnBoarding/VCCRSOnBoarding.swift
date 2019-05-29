//
//  VCCRSOnBoarding.swift
//  bukadana
//
//  Created by Gaenael on 2/10/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import FSPagerView

class VCCRSOnBoarding: UIViewController {

    @IBOutlet weak var pgControl: UIPageControl!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var CCarousel: FSPagerView!{
        didSet {
            self.CCarousel.register(UINib(nibName: "CRSOnBoarding", bundle: nil), forCellWithReuseIdentifier: "CRSOnBoarding")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgView.image = UIImage(named: "bg")
        // Do any additional setup after loading the view.
        self.CCarousel.transformer = FSPagerViewTransformer(type:.linear)
        self.CCarousel.delegate   = self
        self.CCarousel.dataSource = self
        
        let transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.CCarousel.itemSize = self.CCarousel.frame.size.applying(transform)
        
        self.CCarousel.decelerationDistance = FSPagerView.automaticDistance
        
        pgControl.numberOfPages = getBoarding().count
    }

    func lewati() {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let sb: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        let nav = sb.instantiateViewController(withIdentifier: "NavAuth") as? UINavigationController
        appdelegate.window!.rootViewController = nav
    }
    
    func getBoarding() -> [[String:String]]{
        var arr = [[String:String]]()
        
        var arr1      = [String:String]()
        arr1["title"] = "Akses di multi perangkat"
        arr1["desc"]  = "BKDana hadir di multi platform, baik di Web, Android dan iOS, memudahkan transaksi dimanapun dan kapanpun"
        arr.append(arr1)
        
        var arr2      = [String:String]()
        arr2["title"] = "Risiko Terukur & Transparan"
        arr2["desc"]  = "BKDana hanya menyalurkan kredit ke peminjam yang terverifikasi dan dilengkapi analisa credit scoring melalui jejak digital terpercaya"
        arr.append(arr2)
        
        var arr3      = [String:String]()
        arr3["title"] = "Penggunaan Mudah & Aman"
        arr3["desc"]  = "Platform BKDana sangat mudah digunakan dan diawasi oleh OJK"
        arr.append(arr3)
        
        return arr
    }
}

extension VCCRSOnBoarding: FSPagerViewDelegate, FSPagerViewDataSource{
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return getBoarding().count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let data = getBoarding()[index]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CRSOnBoarding", at: index) as! CRSOnBoarding
        cell.setData(data: data)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        lewati()
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pgControl.currentPage = targetIndex
    }
}

