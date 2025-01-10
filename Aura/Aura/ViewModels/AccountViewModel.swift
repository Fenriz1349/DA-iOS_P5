//
//  AccountDetailViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

class AccountViewModel: ObservableObject {
    let repository: AccountRepository
    @Published var  user: User
    init(repository: AccountRepository, user: User) {
        self.repository = repository
        self.user = user
    }
    
    @MainActor
    func setUser() async {
        guard let accountResponse = await repository.getAccountResponse(from: user.userEmail.emailAdress) else {
            user = User.defaultUser
            return
        }
        user.updateUser(from: accountResponse)
    }
}
