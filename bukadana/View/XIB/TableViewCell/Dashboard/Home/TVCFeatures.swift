//
//  TVCFeatures.swift
//  bukadana
//
//  Created by Gaenael on 1/6/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

protocol TVCFeaturesDelegate{
    func features(Index: Int)
}

class TVCFeatures: UITableViewCell {

    var delegate: TVCFeaturesDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        setupFeatures()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupFeatures(){
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        BKDNView.registerNibCollectionView(clView: collectionView, nibName: "CVCFeature")
        
        pageControl.numberOfPages = getFeatures().count
    }
    
    func getFeatures() -> [[String:String]]{
        var arr = [[String:String]]()
        
        var arr1      = [String:String]()
        arr1["bg_im"] = "ico_card"
        arr1["ic_im"] = "icon_f1"
        arr1["title"] = "BKDana Kilat"
        arr1["desc"]  = "Butuh dana Kilat 1 - 2 Juta? Seperti biaya Rumah Sakit, Sekolah, Kontrakan, Dll, Proses persetujuan hanya 15 menit!"
        arr.append(arr1)
        
        var arr2      = [String:String]()
        arr2["bg_im"] = "ico_card2"
        arr2["ic_im"] = "icon_f2"
        arr2["title"] = "BKDana Mikro"
        arr2["desc"]  = "Pinjaman Mikro (Usaha Kecil) untuk solusi Bisnis anda. Platform maksimal sampai dengan 50 juta!"
        arr.append(arr2)
        
        return arr
    }
}

extension TVCFeatures: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getFeatures().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = getFeatures()[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCFeature", for: indexPath) as! CVCFeature
        cell.setData(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 8)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        switch x {
        case 0:
            self.pageControl.currentPage = 0
        default:
            self.pageControl.currentPage = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.features(Index: indexPath.row)
    }
}
