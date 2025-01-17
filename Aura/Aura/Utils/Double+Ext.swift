//
//  Double+Ext.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import Foundation

extension Double {
    func toEuroFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.groupingSize = 3
        numberFormatter.decimalSeparator = ","
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            return "\(formattedNumber) €"
        }
        return ""
    }
}
