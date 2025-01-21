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
    
    /// Permet de set isLogged à true et le userApp à celui passer en paramètre
    /// - Parameter user: le user qui s'est loggé
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
    
    /// Pour mettre à jour userApp après le log avec des données récupérées et créer accountViewModel et moneyTransferViewModel
    func updateAppViewModel() {
        guard isLogged else { return }
        
        // Créer un AccountViewModel
        let accountRepository = AccountRepository(client: ConnectorAccount())
        self.accountViewModel = AccountViewModel(repository: accountRepository, appViewModel: self)
        
        // Créer un MoneyTransferViewModel
        let moneytransferRepository = MoneyTransfertRepository(client: ConnectorMoneyTransfer())
        self.moneyTransferViewModel = MoneyTransferViewModel(repository: moneytransferRepository, appViewModel: self)
    }
}
