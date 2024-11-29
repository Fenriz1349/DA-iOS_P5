//
//  AccountDetailViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

class AccountDetailViewModel: ObservableObject {
    @Published var totalAmount: Double = 12345.67
    @Published var recentTransactions: [Transaction] = [
        Transaction(description: "Starbucks", amount: -5.50),
        Transaction(description: "Amazon Purchase", amount: -34.99),
        Transaction(description: "Salary", amount: 2500.00)
    ]
}
