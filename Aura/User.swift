//
//  User.swift
//  Aura
//
//  Created by Julien Cotte on 28/11/2024.
//

import Foundation

class User: Identifiable {
    let id = UUID()
    let userEmail : Email
    var currentBalance: Double
    var transactions: [Transaction]
    
    var totalAmount: Double {
        return transactions.map {$0.value}.reduce(0,+)
    }
    
    var email: String {
        self.userEmail.emailAdress
    }
    
    init(userEmail: Email, currentBalance: Double = 0.0, transactions: [Transaction] = []) {
        self.userEmail = userEmail
        self.currentBalance = currentBalance
        self.transactions = transactions
    }
}
