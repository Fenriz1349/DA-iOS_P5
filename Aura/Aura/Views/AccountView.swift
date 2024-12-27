//
//  AccountDetailView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Large Header displaying total amount
            AccountHeader(balance: viewModel.user.currentBalance)
            
            // Display recent transactions
            RecentTransactionList(transactions: viewModel.user.transactions.getRecentTransactions(limit: 3))
            
            // Button to see details of transactions
            Button(action: {
            }) {
                HStack {
                    Image(systemName: "list.bullet")
                    Text("See Transaction Details")
                }
                .padding()
                .background(Color(hex: "#94A684"))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding([.horizontal, .bottom])
            
            Spacer()
        }
        .onTapGesture {
                    self.endEditing(true)  // This will dismiss the keyboard when tapping outside
                }
    }
        
}

//#Preview {
//    AccountView(viewModel: AccountViewModel(repository: <#AccountRepository#>, user: <#User#>))
//}
