//
//  BKDNDate.swift
//  bukadana
//
//  Created by Gaenael on 3/2/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

struct BKDNDate {
    
    enum typeDate: String {
        case dtV1   = "yyyy-MM-dd"
        case dtV2   = "dd/MM/yyyy"
        case dtFULL = "yyyy-MM-dd HH:mm:ss"
    }
    
    static func getDate(from interval : TimeInterval, format: typeDate) -> String{
        let date = Date(timeIntervalSince1970: interval)
        
        let formatter = formatDate(format: format.rawValue)
        
        return formatter.string(from: date)
    }
    
    static func format(from date: String, from: typeDate, to: typeDate) -> String{
        let formatter = formatDate(format: from.rawValue)
        let dt1       = formatter.date(from: date)!
        
        let formatter1 = formatDate(format: to.rawValue)
        let dt2       = formatter1.string(from: dt1)
        
        return dt2
    }
    
    private static func formatDate(format: String) -> DateFormatter{
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = format
        
        return formatter
    }
}
