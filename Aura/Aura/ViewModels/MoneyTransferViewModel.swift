//
//  MoneyTransferViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

@MainActor
class MoneyTransferViewModel: ObservableObject {
    private let repository: MoneyTransfertRepository
    @Published var transferErrorMessage: String?
    @Published var transferIsError: Bool = true

    let appViewModel: AppViewModel
    
    init(repository: MoneyTransfertRepository, appViewModel: AppViewModel) {
        self.repository = repository
        self.appViewModel = appViewModel
    }

    func sendMoney(recipient: String, amount: String) async {
        guard recipient.isValidEmail() || recipient.isValidPhoneNumber() else {
            transferIsError = true
            transferErrorMessage = "wrongRecipient".localized
            return
        }
        guard let decimal = amount.toDecimal() else {
            transferIsError = true
            transferErrorMessage = "wrongAmmount".localized
            return
        }
        let user = appViewModel.userApp
        if await repository.trySendMoney(username: user.email, recipient: recipient, amount: decimal) {
            let amountString = decimal.toEuroFormat()
            let sucessMessage = String(format: NSLocalizedString("transferSucess".localized, comment: ""), amountString, recipient)
            transferErrorMessage = sucessMessage
            transferIsError = false
        } else {
            transferIsError = true
            transferErrorMessage = "transferFail".localized
        }
    }
}
