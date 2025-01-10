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
}
