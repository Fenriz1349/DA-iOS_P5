//
//  AccountRow.swift
//  Aura
//
//  Created by Julien Cotte on 27/12/2024.
//

import SwiftUI

// Represente une ligne dans les listes de transactions
struct AccountRow: View {
    let transaction: Transaction
    var body: some View {
        HStack {
            Image(systemName: transaction.value >= 0.0 ? IconName.upArrow : IconName.dowArrow)
                .foregroundColor(transaction.value >= 0.0 ? .green : .red)
            Text(transaction.label)
            Spacer()
            Text(transaction.value.toEuroFormat())
                .fontWeight(.bold)
                .foregroundColor(transaction.value >= 0.0 ? .green : .red)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding([.horizontal])    }
}

#Preview {
    AccountRow(transaction: Transaction(label: "Salaire", value: 666))
}
