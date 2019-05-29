//
//  BKDNConfig.swift
//  bukadana
//
//  Created by Gaenael on 1/1/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//  

import UIKit

struct BKDNConfig {
    
    static let is_production = false //Development
//    static let is_production = true //Production
    
    static func getHost(url:String) -> String{
        if is_production{
            return "http://149.129.243.130" + url
        }
        else{
            return "http://149.129.243.130" + url
        }
    }
}

struct BKDNUrl {
    private static let AUTH     = "/auth"
    private static let MEMBER   = "/member"
    private static let PEMINJAM = "/transaksi_peminjam"
    private static let PINJAMAN = "/pinjaman"
    private static let PENDANA  = "/transaksi_pendana"
    private static let PROFILE  = "/profile"
    //MARK: AUTH
    static let login       = AUTH + "/login"
    static let CEKPASS     = MEMBER + "/cek_password"
    static let CEKBIAYA    = MEMBER + "/cek_biayai"
    
    static let regPeminjam = "/register_peminjam/submit_reg"
    static let regPendana  = "/register_pendana/submit_register"
    
    static let mydata      = MEMBER + "/mydata"
    static let mysaldo     = MEMBER + "/mysaldo"
    static let datatrans   = "/home/data_transaksi"
    
    //MARK: TransaksiPeminjam
    static let TPeminjamList   = PEMINJAM + "/list"
    static let TPeminjamDetail = PEMINJAM + "/detail"
    
    //MARK: TransaksiPendana
    static let TPendanaList    = PENDANA + "/list"
    
    //MARK: Top Up
    static let TOPUP     = "/topup"
    static let TPUList   = TOPUP + "/list"
    static let TPUSubmit = TOPUP + "/submit"
    
    //MARK: REDEEM
    static let REDEEM       = "/redeem"
    static let REDEEMLIST   = REDEEM + "/list"
    static let REDEEMSUBMIT = REDEEM + "/submit"
    
    //MARK: PROFILE
    static let UPDATEINFOAKUN = PROFILE + "/update_informasiakun"
    static let UPDATEINFOPASS = PROFILE + "/update_password"
    static let UPDATEINFOALAM = PROFILE + "/update_informasialamat"
    
    //MARK: REKENING KORAN
    static let REKKORANLIST = "/rekening_koran/list"
    
    //MARK: DAFTAR PEMINJAM
    static let PEMINJAMLIST   = "/daftar_peminjam/index"
    static let PEMINJAMDETAIL = "/daftar_peminjam/detail"
    
    //MARK: KILAT
    static let PSubmitKilat1 = PINJAMAN + "/submit_kilat1"
    static let PSubmitKilat2 = PINJAMAN + "/submit_kilat2"
    static let PSubmitKilat3 = PINJAMAN + "/submit_kilat3"
    
    //MARK: MIKRO
    static let PSubmitMikro1 = PINJAMAN + "/submit_mikro1"
    static let PSubmitMikro2 = PINJAMAN + "/submit_mikro2"
    static let PSubmitMikro3 = PINJAMAN + "/submit_mikro3"
    
    //MARK: MIKRO
    static let PProvinsiList = "/province/list"
    static let PBankList     = "/bank/list"
    static let PengKilat     = PINJAMAN + "/pengajuan_kilat"
    static let PengMikro     = PINJAMAN + "/pengajuan_mikro"
    static let CheckPinj     = PINJAMAN + "/cek_pinjaman_aktif_ios"
    
    static let PENDSUBMIT    = "/pendanaan/submit"
    static let PEMBSUBMIT    = "/pembayaran_cicilan_ios/submit"
}

struct BKDNHTTPHeader {
    static func getHeaderAccess() -> [String:String]{
        return [
            "Authorization" : BUserKeyModel.getToken()
        ]
    }
    static func getHeaderAccessEncode() -> [String:String]{
        return [
            "Authorization" : BUserKeyModel.getToken(),
            "Content-Type"  : "application/x-www-form-urlencoded"
        ]
    }
}
