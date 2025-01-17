//
//  AuthenticationViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

// Le viewModel sert à fournir les éléments aux vues, et à orchestrer les appels au repository
// Il gère les interactions avec l'utilisateur
@MainActor
class AuthenticationViewModel: ObservableObject {
    private let repository: AuthenticationRepository
    private let keychain: KeychainServiceProtocol
    @Published var authenticationErrorMessage: String?
    @Published var autenticationIsError: Bool = true
    let appViewModel: AppViewModel
    let onLoginSucceed: (User) -> Void
    
    init(onLoginSucceed: @escaping (User) -> Void,
             appViewModel: AppViewModel,
             repository: AuthenticationRepository = AuthenticationRepository(),
             keychain: KeychainServiceProtocol = KeychainService()
        ) {
            self.onLoginSucceed = onLoginSucceed
            self.appViewModel = appViewModel
            self.repository = repository
            self.keychain = keychain
        }
            
    func login(usermail: String, password: String) async {
        // Vérifier la connexion au serveur
        guard await repository.tryGet() else {
            autenticationIsError = true
            authenticationErrorMessage = "connexionFailed".localized
            return
        }
        
        // Vérifier le format de l'email
        guard let username = Email.from(usermail) else {
            autenticationIsError = true
            authenticationErrorMessage = "invalidMailFormat".localized
            return
        }
        
        // Récupérer le token
        guard let token = await repository.getTokenFrom(username: username, password: password) else {
            autenticationIsError = true
            authenticationErrorMessage = "wrongLogin".localized
            return
        }
        
        // Sauvegarder le token dans le Keychain
        guard keychain.save(key: usermail, data: Data(token.uuidString.utf8)) else {
            autenticationIsError = true
            authenticationErrorMessage = "tokenFail".localized
            return
        }
        
        // Créer un utilisateur
        let user = User(userEmail: username)
        
        // Login réussi
        appViewModel.loginUser(user: user)
        onLoginSucceed(user)
        print("L'utilisateur \(appViewModel.userApp.email) vient nous dire Ah que Coucou!")
    }
}
