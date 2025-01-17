//
//  AppViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

@MainActor
class AppViewModel: ObservableObject {
    @Published var isLogged: Bool = false
    @Published var userApp: User = User.defaultUser
    var accountViewModel: AccountViewModel?
    var moneyTransferViewModel: MoneyTransferViewModel?
    
    func loginUser(user: User) {
        self.isLogged = true
        self.userApp = user
        updateAppViewModel()
    }
        
    var authenticationViewModel: AuthenticationViewModel {
        AuthenticationViewModel(
            onLoginSucceed: { [weak self] user in
                self?.loginUser(user: user)
            },
            appViewModel: self
        )
    }
    
    func updateAppViewModel() {
        guard isLogged else { return }
        
        // Créer un AccountViewModel
        let accountRepository = AccountRepository(client: ConnectorAccount())
        self.accountViewModel = AccountViewModel(repository: accountRepository, appViewModel: self)
        
        // Créer un MoneyTransferViewModel
        let moneytransferRepository = MoneyTransfertRepository(client: ConnectorMoneyTransfer())
        self.moneyTransferViewModel = MoneyTransferViewModel(repository: moneytransferRepository, appViewModel: self)
        
        // Appeler setUser() dans AccountViewModel pour récupérer les informations de l'utilisateur
//        Task {
//            await self.accountViewModel?.updateAppUser()
//        }
    }
}
