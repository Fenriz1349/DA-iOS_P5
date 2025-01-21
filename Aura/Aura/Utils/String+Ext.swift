//
//  String+Ext.swift
//  Aura
//
//  Created by Julien Cotte on 10/01/2025.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    /// Pour convertir un String en Decimal
    /// - Returns: le Decimal ou nil si la String n'est pas valide
    func toDecimal() -> Decimal? {
        let string = self.replacingOccurrences(of: ",", with: ".")
        guard let double = Double(string) else { return nil}
        return Decimal(double)
    }
    
    /// Pour tester si une String est une adresse email valide
    /// - Returns: true si elle l'est, false sinon
    func isValidEmail() -> Bool {
        return Email.isValid(self)
    }
    
    /// Pour tester si une String est un numéro de téléphone au format français
    /// Donc qui comment soit par +33 ou 0 et suivit de 9 chiffres
    /// - Returns: true si il n'est, faut sinon
    func isValidPhoneNumber() -> Bool {
        let regexPlus33 = #"^\+33\d{9}$"#
        let regexZero = #"^0\d{9}$"#
        let trimmed = self.replacingOccurrences(of: " ", with: "")
        let regexPlus33Match = trimmed.range(of: regexPlus33, options: .regularExpression) != nil
        let regexZeroMatch = trimmed.range(of: regexZero, options: .regularExpression) != nil
        return regexPlus33Match || regexZeroMatch
    }
}
