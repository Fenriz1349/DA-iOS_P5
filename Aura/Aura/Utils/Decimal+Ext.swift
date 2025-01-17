//
//  Decimal+Ext.swift
//  Aura
//
//  Created by Julien Cotte on 12/01/2025.
//

import Foundation

extension Decimal {
    func toEuroFormat() -> String {
        return String(format: "%.2f€", NSDecimalNumber(decimal: self).doubleValue).replacingOccurrences(of: ".", with: ",")
    }
}
