//
//  User.swift
//  Aura
//
//  Created by Julien Cotte on 28/11/2024.
//

import Foundation

// Class d'un user de l'app, elle permet de stocke son username, et ses datas recupérées 
class User: Identifiable {
    let id = UUID()
    let username : String
    var currentBalance: Double
    var transactions: [Transaction]
    
    init(username: String, currentBalance: Double = 0.0, transactions: [Transaction] = []) {
        self.username = username
        self.currentBalance = currentBalance
        self.transactions = transactions
    }
}
