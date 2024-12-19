//
//  User.swift
//  Aura
//
//  Created by Julien Cotte on 28/11/2024.
//

import Foundation

class User: Identifiable {
    let id = UUID()
    var userEmail : Email
    var transactions: [Transaction]
    // to do: ne pas stocker le token et utiliser un keychain service
    let token: UUID?
    
    var totalAmount: Double {
        return transactions.map {$0.amount}.reduce(0,+)
    }
    
    init(userEmail: Email, transactions: [Transaction], token: UUID?) {
        self.userEmail = userEmail
        self.transactions = transactions
        self.token = token
    }
}
