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
                CustomImage(image: IconName.euroCircle, size: 80, color: .customGreen)
                RecentTransactionList(transactions: viewModel.user.transactions.getRecentTransactions(limit: 3))
                
                NavigationLink(destination: AccountDetailView(user: viewModel.user)) {
                    CustomButton(icon: IconName.listBullet, text: "seeDetails".localized, color: .customGreen)
                }
                .padding(.horizontal)
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
        .environment(\.locale, Locale(identifier: "en"))
}
