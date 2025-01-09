//
//  AccountDetailView.swift
//  Aura
//
//  Created by Julien Cotte on 09/01/2025.
//

import SwiftUI

struct AccountDetailView: View {
    let user : User
    
    var body: some View {
        VStack (spacing: 20) {
            AccountHeader(balance: user.currentBalance)
                .padding(.top, 20)
            AllTransactionsList(transactions: user.transactions)
        }
    }
}

#Preview {
    AccountDetailView(user: User.defaultUser)
}
