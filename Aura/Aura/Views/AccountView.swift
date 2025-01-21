//
//  AccountDetailView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var accountViewModel: AccountViewModel
    
    private var user : User {
        accountViewModel.appViewModel.userApp
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                AccountHeader(balance: user.currentBalance)
                CustomImage(image: IconName.euroCircle, size: 80, color: .accentColor)
                TransactionsList(title: "recentTransaction".localized,
                                 limit: 3,
                                 transactions: user.transactions)
                
                NavigationLink(destination: AccountDetailView(user: accountViewModel.appViewModel.userApp)) {
                    CustomButton(icon: IconName.listBullet,
                                 message: "seeDetails".localized,
                                 color: .accent)
                }
                VStack {
                    if let message = accountViewModel.accountErrorMessage {
                        InfoLabel(message: message, isError: accountViewModel.accountIsError)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .task {
                                // Affiche le label pendant 5 secondes puis réinstalle la variable à false
                                try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
                                accountViewModel.accountErrorMessage  = nil
                                accountViewModel.accountIsError = true
                            }
                    }
                }
                .frame(height:80)
                Spacer()
            }
            .padding(.horizontal)
            .onTapGesture {
                self.endEditing(true) 
            }
        }
    }
}

#Preview {
    AccountView(accountViewModel: AccountViewModel(repository: AccountRepository(), appViewModel: AppViewModel()))
}
