
//
//  BKDNDataArray.swift
//  bukadana
//
//  Created by Gaenael on 2/12/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

struct BKDNDataArray {
    
    static func getBank() -> [[String:String]]{
        return [
            ["title":"Bank BCA"],
            ["title":"Bank BNI 46"],
            ["title":"Bank BRI"],
            ["title":"Bank CIMB"],
            ["title":"Bank Mandiri"]
        ]
    }
    
    static func getListJenisKelamin() -> [[String:String]]{
        return [
            ["title":"Laki"],
            ["title":"Perempuan"]
        ]
    }
    
    static func getListProvinsi() -> [[String:String]]{
        return [
            ["title":"Bali"],
            ["title":"Bangka Belitung"],
            ["title":"Banten"],
            ["title":"Bengkulu"],
            ["title":"DI Yogyakarta"],
            ["title":"DKI Jakarta"],
            ["title":"Gorontalo"],
            ["title":"Jambi"],
            ["title":"Jawa Barat"],
            ["title":"Jawa Tengah"],
            ["title":"Jawa Timur"],
            ["title":"Kalimantan Barat"],
            ["title":"Kalimantan Selatan"],
            ["title":"Kalimantan Tengah"],
            ["title":"Kalimantan Timur"],
            ["title":"Kalimantan Utara"],
            ["title":"Kepulauan Riau"],
            ["title":"Lampung"],
            ["title":"Maluku"],
            ["title":"Maluku Utara"],
            ["title":"Nusa Tenggara Barat"],
            ["title":"Nusa Tenggara Timur"],
            ["title":"Papua"],
            ["title":"Papua Barat"],
            ["title":"Riau"],
            ["title":"Sulawesi Barat"],
            ["title":"Sulawesi Selatan"],
            ["title":"Sulawesi Tengah"],
            ["title":"Sulawesi Tenggara"],
            ["title":"Sulawesi Utara"],
            ["title":"Sumatera Barat"],
            ["title":"Sumatera Selatan"],
            ["title":"Sumatera Utara"]
        ]
    }
    
    static func getListPendidikan() -> [[String:String]]{
        return [
            ["title":"SD"],
            ["title":"SMP"],
            ["title":"SMA"],
            ["title":"Diploma"],
            ["title":"Sarjana"]
        ]
    }
    
    static func getListPekerjaan() -> [[String:String]]{
        return [
            ["title":"PNS"],
            ["title":"BUMN"],
            ["title":"Swasta"],
            ["title":"Wiraswasta"],
            ["title":"Lain-lain"]
        ]
    }
    
    static func getIndexPendidikan(str: String) -> String{
        var index = 1
        for data in getListPendidikan(){
            if str == data["title"]{
                break
            }
            index += 1
        }
        
        return "\(index)"
    }
    
    static func getIndexPekerjaan(str: String) -> String{
        var index = 1
        for data in getListPekerjaan(){
            if str == data["title"]{
                break
            }
            index += 1
        }
        
        return "\(index)"
    }
    
    static func getListStatusKaryawan() -> [[String:String]]{
        return [
            ["title":"Contract"],
            ["title":"Tetap"]
        ]
    }
}
