//
//  AccountDetailViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

@MainActor
class AccountViewModel: ObservableObject {
    private let repository: AccountRepository
    @Published var accountErrorMessage: String?
    @Published var accountIsError: Bool = true
    let appViewModel: AppViewModel
    
    init(repository: AccountRepository, appViewModel: AppViewModel) {
        self.repository = repository
        self.appViewModel = appViewModel
    }
    
    func getUserResponse() async -> AccountResponse? {
        guard let accountResponse = await repository.getAccountResponse(from: appViewModel.userApp.email) else {
            accountIsError = true
            accountErrorMessage = "fetchAccount".localized
            return nil
        }
        return accountResponse
    }
    
    func updateAppUser() async {
        guard let response = await getUserResponse() else {
            accountIsError = true
            accountErrorMessage = "fetchAccount".localized
            return
        }

        appViewModel.userApp.updateUser(from: response)
        let sucessMessage = String(format: NSLocalizedString("loginSucess".localized, comment: ""), appViewModel.userApp.email)
        accountErrorMessage = sucessMessage
        accountIsError = false
        objectWillChange.send()
    }
}
