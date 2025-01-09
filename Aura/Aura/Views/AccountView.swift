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
        NavigationView {
            VStack(spacing: 20) {
                AccountHeader(balance: viewModel.user.currentBalance)
                Image(systemName: "eurosign.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .foregroundColor(Color(hex: "#94A684"))
                // Display recent transactions
                RecentTransactionList(transactions: viewModel.user.transactions.getRecentTransactions(limit: 3))
                
                // Button to see details of transactions
                NavigationLink(destination: AccountDetailView(user: viewModel.user)) {
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
        
}

#Preview {
    AccountView(viewModel: AccountViewModel(repository: AccountRepository(), user: User.defaultUser))
}
