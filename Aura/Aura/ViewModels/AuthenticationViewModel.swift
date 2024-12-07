//
//  AuthenticationViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

class AuthenticationViewModel: ObservableObject {
    let repository: AuthenticationRepository
    @Published var user: User?
    @Published var errorMessage : String?
    
    let onLoginSucceed: (() -> ())
    
    init(_ callback: @escaping () -> (), repository: AuthenticationRepository = AuthenticationRepository()) {
        self.onLoginSucceed = callback
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
            
    func getTokenForUser(username: Email, password: String) async -> UUID? {
        do {
            let token = try await repository.getTokenFrom(username: username, password: password)
            return token
        } catch {
            return nil
        }
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
        guard let token = await getTokenForUser(username: username, password: password) else {
            setErrorMessage("Mauvaise adresse mail / mot de passe")
            return
        }
        
        // Créer un utilisateur
        let user = User(userEmail: username, userPassword: password, transactions: [], token: token)
        
        // Login réussi
        self.user = user
        print("Login avec \(self.user!.userEmail.emailAdress) et token \(String(describing: user.token))")
        onLoginSucceed()
    }
}
