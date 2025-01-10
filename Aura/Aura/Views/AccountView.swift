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
                Image(systemName: Icons.euroCircle)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .foregroundColor(.customGreen)
                RecentTransactionList(transactions: viewModel.user.transactions.getRecentTransactions(limit: 3))
                
                // Button to see details of transactions
                NavigationLink(destination: AccountDetailView(user: viewModel.user)) {
                    HStack {
                        Image(systemName: Icons.listBullet)
                        Text(Texts.seeDetails)
                    }
                    .padding()
                    .background(.customGreen)
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
