//
//  Last3TransactionList.swift
//  Aura
//
//  Created by Julien Cotte on 27/12/2024.
//

import SwiftUI

struct RecentTransactionList: View {
    let transactions : [Transaction]
    private var recentTransaction : [Transaction] {
        transactions.getRecentTransactions(limit: 3)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Transactions")
                .font(.headline)
                .padding([.horizontal])
            ForEach(recentTransaction) { transaction in
                AccountRow(transaction: transaction)
            }
        }
    }
}

#Preview {
    RecentTransactionList(transactions: User.defaultUser.transactions)
}
