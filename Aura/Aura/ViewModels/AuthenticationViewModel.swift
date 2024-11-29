//
//  AuthenticationViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

class AuthenticationViewModel: ObservableObject {
    let repository = AuthentificationRepository()
    @Published var user: User?
    @Published var showError = false
    @Published var errorMessage : String?
    
    let onLoginSucceed: (() -> ())
    
    init(_ callback: @escaping () -> ()) {
        self.onLoginSucceed = callback
    }
    
    // fonction pour configurer le message d'erreur et l'afficher
    func setErrorMessage(_ message: String) {
        errorMessage = message
        showError = true
    }
    
    func hideErrorMessage() {
        errorMessage = nil
        showError = false
    }
    
    func login(usermail: String, password: String) async {
        do {
            // Essayer de se connecter au serveur
            guard let connect = try await repository.tryGet() else {
                setErrorMessage("Erreur de connexion")
                return
            }
            print(connect)
            
            // Vérifier le format de l'email
            guard let username = Email.from(usermail) else {
                setErrorMessage("Le format de l'email n'est pas valide")
                return
            }
            
            // Créer un utilisateur
            user = User(userEmail: username, userPassword: password, transactions: [])
            guard let user = user else {
                setErrorMessage("Erreur à la création de l'utilisateur")
                return
            }
            // Récuperation du token du user et ajout dans celui ci si il est valide
            guard let token = try await repository.getTokenFrom(user) else {
                setErrorMessage("Mauvaise adresse mail / mot de passe")
                return
            }
            user.token = token
            // Login réussi
            print("Login with \(user.userEmail.emailAdress) and \(user.userPassword) avec comme token \(String(describing: user.token))")
            onLoginSucceed()
        } catch {
            // Gestion des erreurs
            setErrorMessage("Une erreur s'est produite : \(error.localizedDescription)")
        }
    }

}
