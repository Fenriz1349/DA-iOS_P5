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
    var currentBalance: Double
    var transactions: [Transaction]
    
    var totalAmount: Double {
        return transactions.map {$0.value}.reduce(0,+)
    }
    
    init(userEmail: Email, currentBalance: Double = 0.0, transactions: [Transaction] = []) {
        self.userEmail = userEmail
        self.currentBalance = currentBalance
        self.transactions = transactions
    }
    
    
}
