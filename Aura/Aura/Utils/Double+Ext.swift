//
//  Double+Ext.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import Foundation

extension Double {
    /// Permet de convertir un Double en String au format Euro
    /// - Returns: le Double, avec un espace entre chaque millier et le symbole €
    func toEuroFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.groupingSize = 3
        numberFormatter.decimalSeparator = ","
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        var formattedString = ""
        
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
            formattedString = "\(formattedNumber)€"
        }
        return formattedString
    }
}
