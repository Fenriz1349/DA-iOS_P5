//
//  Decimal+Ext.swift
//  Aura
//
//  Created by Julien Cotte on 12/01/2025.
//

import Foundation

extension Decimal {
    /// Permet de convertir un Decimal en String au format Euro
    /// - Returns: le Decimal, avec un espace entre chaque millier et le symbole €
    func toEuroFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.groupingSize = 3
        numberFormatter.decimalSeparator = ","
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        var formattedString = ""
        
        if let formattedNumber = numberFormatter.string(from: self as NSDecimalNumber) {
            formattedString = "\(formattedNumber)€"
        }
        return formattedString
    }
}
