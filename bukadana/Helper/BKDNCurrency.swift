//
//  BKDNCurrency.swift
//  bukadana
//
//  Created by Gaenael on 2/17/19.
//  Copyright © 2019 Gaenael. All rights reserved.
//

import UIKit

struct BKDNCurrency {
    
    static func formatCurrency(_ value: UInt32) -> String {
        
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        
        return formatter.string(from: value as NSNumber)!
        
    }
    
}
