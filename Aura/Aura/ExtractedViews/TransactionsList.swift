//
//  AllTransactionsList.swift
//  Aura
//
//  Created by Julien Cotte on 09/01/2025.
//

import SwiftUI

// Permet d'afficher la liste de toutes les transactions avec possibilité de limiter leur nombre
struct TransactionsList: View {
    let title: String
    var limit: Int? = nil
    let transactions : [Transaction]
    var selectedTransaction : [Transaction] {
        if let limit = limit {
            return transactions.getRecentTransactions(limit: limit)
        } else {
            return transactions
        }
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.headline)
                .padding([.horizontal])
            ScrollView {
                ForEach(selectedTransaction) { transaction in
                    AccountRow(transaction: transaction)
                }
            }
        }
    }
}

#Preview {
    TransactionsList(title: "allTransaction".localized, limit: 2, transactions: User.defaultUser.transactions)
}
