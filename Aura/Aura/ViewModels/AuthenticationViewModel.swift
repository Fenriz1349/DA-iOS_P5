//
//  AuthenticationViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

// Le viewModel sert à fournir les éléments aux vues, et à orchestrer les appels au repository
// Il gère less interactions avec l'utilisateur
class AuthenticationViewModel: ObservableObject {
    let repository: AuthenticationRepository
    @Published var user: User?
    @Published var errorMessage : String?
    
    let onLoginSucceed: () -> Void
    
    init(onLoginSucceed: @escaping () -> Void, repository: AuthenticationRepository = AuthenticationRepository()) {
        self.onLoginSucceed = onLoginSucceed
        self.repository = repository
    }
    
    @MainActor
    // fonction pour configurer le message d'erreur et l'afficher
    func setErrorMessage(_ message: String) {
        errorMessage = message
    }
    
    @MainActor
    func hideErrorMessage() {
        errorMessage = nil
    }
            
    @MainActor
    func login(usermail: String, password: String) async {
        // Vérifier la connexion au serveur
        guard await repository.tryGet() else {
            setErrorMessage("Erreur de connexion au serveur")
            return
        }
        
        // Vérifier le format de l'email
        guard let username = Email.from(usermail) else {
            setErrorMessage("Le format de l'email n'est pas valide")
            return
        }
        
        // Récupérer le token
        guard let token = await repository.getTokenFrom(username: username, password: password) else {
            setErrorMessage("Mauvaise adresse mail / mot de passe")
            return
        }
        
        // Sauvegarder le token dans le Keychain
        guard KeychainService.save(key: "authToken", data: Data(token.uuidString.utf8)) else {
            setErrorMessage("Échec de la sauvegarde du token")
            return
        }
        
        // Créer un utilisateur
        let user = User(userEmail: username, transactions: [])
        
        // Login réussi
        self.user = user
        print("L'utilisateur \(self.user!.userEmail.emailAdress) vient nous dire Ah que Coucou!")
        onLoginSucceed()
    }
}
