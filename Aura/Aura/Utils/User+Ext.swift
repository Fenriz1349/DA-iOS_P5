//
//  User+Ext.swift
//  Aura
//
//  Created by Julien Cotte on 27/12/2024.
//

import Foundation

extension User {
    /// Permet de mettre à jour les donées du user avec les données du serveur
    /// - Parameter response: la reponse du serveur préalable decodé
    func updateUser(from response: AccountResponse) {
        self.currentBalance = response.currentBalance
        self.transactions = response.transactions
    }
    
    static var defaultUser: User {
        return User(userEmail: Email.from("default@example.com")!, currentBalance: 12345.67, transactions: [
            Transaction(label: "Starbucks", value: -5.50),
            Transaction(label: "Amazon Purchase", value: -34.99),
            Transaction(label: "Salary", value: 2500.00)
        ])
    }
}
