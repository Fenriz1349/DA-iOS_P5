//
//  AppViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

@MainActor
class AppViewModel: ObservableObject {
    @Published var isLogged: Bool
    @Published var user: User
    @Published var errorMessage : String?
    
    var accountViewModel: AccountViewModel?
    init() {
        self.isLogged = false
        self.user = User.defaultUser
    }
    
    func loginUser(user: User) {
        self.isLogged = true
        self.user = user
    }
    
    func logoutUser() {
        self.isLogged = false
        self.user = User.defaultUser
    }
    
    // fonction pour configurer le message d'erreur et l'afficher
    func setErrorMessage(_ message: String) {
        errorMessage = message
    }
    
    func hideErrorMessage() {
        errorMessage = nil
    }
    
    var authenticationViewModel: AuthenticationViewModel {
           return AuthenticationViewModel(onLoginSucceed: { [weak self] user in
               self?.loginUser(user: user)
               self?.updateUserDetails()
           }, appViewModel: self)
       }
    
    func updateUserDetails() {
        guard isLogged else { return }
        
        // Créer un AccountViewModel
        let repository = AccountRepository(client: ConnectorAccount())
        self.accountViewModel = AccountViewModel(repository: repository, user: user)
        
        // Appeler setUser() dans AccountViewModel pour récupérer les informations de l'utilisateur
        Task {
            await accountViewModel?.setUser()
            
            // Une fois les données récupérées, mettre à jour l'utilisateur dans AppViewModel
            if let accountViewModel = accountViewModel {
                self.user = accountViewModel.user
            }
        }
    }
}
