//
//  AllTransactionsList.swift
//  Aura
//
//  Created by Julien Cotte on 09/01/2025.
//

import SwiftUI

struct AllTransactionsList: View {
    let transactions : [Transaction]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(Texts.allTransaction)
                .font(.headline)
                .padding([.horizontal])
            ScrollView {
                ForEach(transactions) { transaction in
                    AccountRow(transaction: transaction)
                }
            }
        }
    }
}

#Preview {
    AllTransactionsList(transactions: User.defaultUser.transactions)
}
