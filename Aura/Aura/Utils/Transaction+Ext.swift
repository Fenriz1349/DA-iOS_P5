//
//  Transaction+Ext.swift
//  Aura
//
//  Created by Julien Cotte on 27/12/2024.
//

import Foundation
// Extenstion pour les Array de Transaction
extension Array where Element == Transaction {
    func getRecentTransactions(limit: Int) -> [Transaction] {
        return Array(self.prefix(limit))
    }
}
