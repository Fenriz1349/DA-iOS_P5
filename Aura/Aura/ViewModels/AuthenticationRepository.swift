//
//  AuthentificationRepository.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import Foundation

// Le repository ne s'occupe que de récuperer les data du Connector pour les mapper avec la logique métier
class AuthenticationRepository {
    private let client: HTTPClientAuthentication
    
    init(client: HTTPClientAuthentication = ConnectorAuthentication()) {
            self.client = client
        }
    
    /// Fonction pour tester la connexion avec le serveur et traiter tous les cas d'erreur.
    /// - Parameter url: l'url pour tester la connexion
    /// - Returns: Si la connexion est bonne elle renvoie "It works!"
    func tryGet(url: URL = AppConfig().baseUrl) async -> Bool {
            let expectedData = "It works!"
            do {
                let data = try await client.performRequest(from: url, with: .GET)
                guard let stringResponse = DataMapping.getStringFrom(data) else {
                    return false
                }
                return stringResponse == expectedData
            } catch {
                return false
            }
        }
    
    /// Permet de récupérer le token du User lors du login
    /// - Parameters:
    ///   - username: le username du user
    ///   - password: le password du user
    /// - Returns: le token si il est au bon format et que le couple username- password est correcte, nil sinon
    func getTokenFrom(username: String, password: String) async -> UUID? {
        do {
            guard username.isValidEmail() else {
                return nil
            }
            let data = try await client.performAuthRequest(username: username, password: password)
            let token = try JSONMapping.jsonAuthDecoder(data) 
            return token
        } catch {
            return nil
        }
    }
}
