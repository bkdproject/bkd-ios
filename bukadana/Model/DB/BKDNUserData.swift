//
//  BKDNUserData.swift
//  bukadana
//
//  Created by Gaenael on 2/10/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit
import RealmSwift

class BKDNUserData: Object {
    @objc dynamic var member_id: String? = ""
    @objc dynamic var email: String? = ""
    @objc dynamic var Nama_pengguna: String? = ""
    @objc dynamic var Nomor_nik: String? = ""
    @objc dynamic var Tempat_lahir: String? = ""
    @objc dynamic var Tanggal_lahir: String? = ""
    @objc dynamic var Jenis_kelamin: String? = ""
    @objc dynamic var Pendidikan: String? = ""
    @objc dynamic var Pekerjaan: String? = ""
    @objc dynamic var Mobileno: String? = ""
    @objc dynamic var Nomor_rekening: String? = ""
    @objc dynamic var nama_perusahaan: String? = ""
    @objc dynamic var no_telp_perusahaan: String? = ""
    @objc dynamic var lama_bekerja: String? = ""
    @objc dynamic var deskripsi_usaha: String? = ""
    @objc dynamic var omzet_usaha: String? = ""
    @objc dynamic var margin_usaha: String? = ""
    @objc dynamic var biaya_operasional_usaha: String? = ""
    @objc dynamic var laba_usaha: String? = ""
    @objc dynamic var jml_bunga_usaha: String? = ""
    @objc dynamic var lama_usaha: String? = ""
    @objc dynamic var Alamat: String? = ""
    @objc dynamic var Kota: String? = ""
    @objc dynamic var Provinsi: String? = ""
    @objc dynamic var Kodepos: String? = ""
    @objc dynamic var peringkat_pengguna_persentase: String? = ""
    
    @objc dynamic var nama_bank: String? = ""
    @objc dynamic var usaha: String? = ""
    @objc dynamic var gaji: String? = ""
    @objc dynamic var nama_atasan: String? = ""
    @objc dynamic var status_karyawan: String? = ""
    @objc dynamic var referensi_1: String? = ""
    @objc dynamic var referensi_2: String? = ""
    @objc dynamic var referensi_nama_1: String? = ""
    @objc dynamic var referensi_nama_2: String? = ""
    
    @objc dynamic var foto_file : String? = ""
    @objc dynamic var foto_pegang_idcard : String? = ""
    @objc dynamic var foto_slip_gaji : String? = ""
    @objc dynamic var foto_surat_ket_kerja : String? = ""
    @objc dynamic var foto_usaha_file : String? = ""
    @objc dynamic var nik_file : String? = ""
    
    @objc dynamic var cek_biaya : Bool = false
}

class BKDNUserDataModel{
    static func save(data: Dictionary<String, Any>){
        
        let model                           = BKDNUserData()
        model.member_id                     = data["member_id"] as? String
        model.email                         = data["email"] as? String
        model.Nama_pengguna                 = data["Nama_pengguna"] as? String
        model.Nomor_nik                     = data["Nomor_nik"] as? String
        model.Tempat_lahir                  = data["Tempat_lahir"] as? String
        model.Tanggal_lahir                 = data["Tanggal_lahir"] as? String
        model.Jenis_kelamin                 = data["Jenis_kelamin"] as? String
        model.Mobileno                      = data["Mobileno"] as? String
        model.Nomor_rekening                = data["Nomor_rekening"] as? String
        model.nama_perusahaan               = data["nama_perusahaan"] as? String
        model.no_telp_perusahaan            = data["no_telp_perusahaan"] as? String
        model.lama_bekerja                  = data["lama_bekerja"] as? String
        model.deskripsi_usaha               = data["deskripsi_usaha"] as? String
        model.omzet_usaha                   = data["omzet_usaha"] as? String
        model.margin_usaha                  = data["margin_usaha"] as? String
        model.laba_usaha                    = data["laba_usaha"] as? String
        model.jml_bunga_usaha               = data["jml_bunga_usaha"] as? String
        model.lama_usaha                    = data["lama_usaha"] as? String
        model.Alamat                        = data["Alamat"] as? String
        model.Kota                          = data["Kota"] as? String
        model.Provinsi                      = data["Provinsi"] as? String
        model.Kodepos                       = data["Kodepos"] as? String
        model.biaya_operasional_usaha       = data["biaya_operasional_usaha"] as? String
        model.peringkat_pengguna_persentase = data["peringkat_pengguna_persentase"] as? String
        
        model.nama_bank              = data["nama_bank"] as? String
        model.usaha                  = data["usaha"] as? String
        model.gaji                   = data["gaji"] as? String
        model.nama_atasan            = data["nama_atasan"] as? String
        model.status_karyawan        = data["status_karyawan"] as? String
        model.referensi_1            = data["referensi_1"] as? String
        model.referensi_2            = data["referensi_2"] as? String
        model.referensi_nama_1       = data["referensi_nama_1"] as? String
        model.referensi_nama_2       = data["referensi_nama_2"] as? String
        
        model.foto_usaha_file        = data["foto_usaha_file"] as? String
        model.foto_pegang_idcard     = data["foto_pegang_idcard"] as? String
        model.foto_file              = data["foto_file"] as? String
        model.foto_slip_gaji         = data["foto_slip_gaji"] as? String
        model.foto_surat_ket_kerja   = data["foto_surat_ket_kerja"] as? String
        model.nik_file               = data["nik_file"] as? String
        
        if let cb = data["is_biaya"] as? String{
            if cb == "Member sudah aktif"{
                model.cek_biaya = true
            }
            else{
                model.cek_biaya = false
            }
        }
        
        if let pnd = data["Pendidikan"] as? String{
            if pnd != "0"{
                let index = (Int(pnd) ?? 1) - 1
                model.Pendidikan = BKDNDataArray.getListPendidikan()[index]["title"]
            }
            else{
                model.Pendidikan = ""
            }
        }
        
        if let pkr = data["Pekerjaan"] as? String{
            if pkr != "0"{
                let index = (Int(pkr) ?? 1) - 1
                model.Pekerjaan = BKDNDataArray.getListPekerjaan()[index]["title"]
            }
            else{
                model.Pekerjaan = ""
            }
        }
        
        self.clear()
        
        self.add(userKey: model)
    }
    
    static func getData() -> BKDNUserData{
        let realm = try! Realm()
        let data = realm.objects(BKDNUserData.self)
        if data.count > 0{
            return data[0]
        }
        else{
            return BKDNUserData()
        }
    }
    
    static func updateCekBiaya(status: Bool){
        let realm = try! Realm()
        let FP = realm.objects(BKDNUserData.self)
        let data    = FP[0]
        try! realm.write {
            data.cek_biaya = status
        }
    }
    
    static func getCekBiaya() -> Bool{
        let realm = try! Realm()
        let data = realm.objects(BKDNUserData.self)
        if data.count > 0{
            return data[0].cek_biaya
        }
        else{
            return false
        }
    }
}

extension BKDNUserDataModel{
    private static func add(userKey: BKDNUserData){
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(userKey)
        }
    }
    
    private static func clear(){
        let realm    = try! Realm()
        let userData = realm.objects(BKDNUserData.self)
        
        try! realm.write {
            realm.delete(userData)
        }
    }
}
