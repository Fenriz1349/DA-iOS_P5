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
    
    var totalAmount: Double {
        return transactions.map {$0.amount}.reduce(0,+)
    }
    
    init(userEmail: Email, transactions: [Transaction]) {
        self.userEmail = userEmail
        self.transactions = transactions
    }
}
