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
    var userPassword: String
    var transactions: [Transaction]
    var token: UUID?
    
    var totalAmount: Double {
        return transactions.map {$0.amount}.reduce(0,+)
    }
    
    init(userEmail: Email, userPassword: String, transactions: [Transaction]) {
        self.userEmail = userEmail
        self.userPassword = userPassword
        self.transactions = transactions
    }
}
