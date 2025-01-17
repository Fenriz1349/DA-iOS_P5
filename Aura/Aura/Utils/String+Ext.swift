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
    
    func toDecimal() -> Decimal? {
        guard let double = Double(self) else { return nil}
        return Decimal(double)
    }
    
    func isValidEmail() -> Bool {
        return Email.isValid(self)
    }
    
    func isValidPhoneNumber() -> Bool {
        let regexPlus33 = #"^\+33\d{9}$"#
        let regexZero = #"^0\d{9}$"#
        let trimmed = self.replacingOccurrences(of: " ", with: "")
        let regexPlus33Match = trimmed.range(of: regexPlus33, options: .regularExpression) != nil
        let regexZeroMatch = trimmed.range(of: regexZero, options: .regularExpression) != nil
        return regexPlus33Match || regexZeroMatch
    }
}
