//
//  Transaction+Ext.swift
//  Aura
//
//  Created by Julien Cotte on 27/12/2024.
//

import Foundation
// Extenstion pour les Array de Transaction
extension Array where Element == Transaction {
    /// Permet de filter un Array de Transaction pour récupérer les premire element de la liste
    /// - Parameter limit: le nombre d'element à récuperer
    /// - Returns: la liste filtrée
    func getRecentTransactions(limit: Int) -> [Transaction] {
        return Array(self.prefix(limit))
    }
}

extension Transaction {
    static var previewTransactions: [Transaction] { [
        Transaction(label: "Starbucks", value: -5.50),
        Transaction(label: "Amazon Purchase", value: -34.99),
        Transaction(label: "Salary", value: 2500.00)
    ]
    }
}
