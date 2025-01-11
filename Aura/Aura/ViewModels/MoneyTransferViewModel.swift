//
//  MoneyTransferViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

@MainActor
class MoneyTransferViewModel: ObservableObject {
    private let repository: MoneyTransfertRepository
    let appViewModel: AppViewModel
    
    init(repository: MoneyTransfertRepository = MoneyTransfertRepository(),
         appViewModel: AppViewModel) {
        self.repository = repository
        self.appViewModel = appViewModel
    }
#warning("configurer le message pour traiter les erreurs, pas en decimal, pas une bonne adresse, erreur de connexion")
    func sendMoney(recipient: String, amount: Decimal) async {
        let user = appViewModel.userApp
        print(user.userEmail.emailAdress)
        if await repository.trySendMoney(username: user.email, recipient: recipient, amount: amount) {
            print("reussite")
            appViewModel.setErrorMessage("Successfully transferred \(amount) to \(recipient)")
        } else {
            print("echec")
            appViewModel.setErrorMessage("Please enter recipient and amount.")
        }
    }
}
