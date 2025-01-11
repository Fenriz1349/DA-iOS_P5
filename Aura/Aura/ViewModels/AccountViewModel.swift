//
//  AccountDetailViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

class AccountViewModel: ObservableObject {
    private let repository: AccountRepository
    let appViewModel: AppViewModel
    
    init(repository: AccountRepository, appViewModel: AppViewModel) {
        self.repository = repository
        self.appViewModel = appViewModel
    }
    
    @MainActor
    func setUser() async {
        guard let accountResponse = await repository.getAccountResponse(from: appViewModel.userApp.email) else {
            return
        }
        appViewModel.userApp.updateUser(from: accountResponse)
    }
}
