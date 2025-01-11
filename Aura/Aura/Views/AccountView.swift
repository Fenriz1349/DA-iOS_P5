//
//  AccountDetailView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel
    var user: User { viewModel.appViewModel.userApp }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                AccountHeader(balance: user.currentBalance)
                CustomImage(image: IconName.euroCircle, size: 80, color: .customGreen)
                RecentTransactionList(transactions: user.transactions.getRecentTransactions(limit: 3))
                
                NavigationLink(destination: AccountDetailView(user: user)) {
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
    AccountView(viewModel: AccountViewModel(repository: AccountRepository(), appViewModel: AppViewModel()))
        .environment(\.locale, Locale(identifier: "en"))
}
