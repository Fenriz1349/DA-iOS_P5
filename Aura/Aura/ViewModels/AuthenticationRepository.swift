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
    
    // Fonction pour tester la connexion avec le serveur et traiter tous les cas d'erreur.
    // Si la connexion est bonne elle renvoie "It works!"
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
    
    func getTokenFrom(username: Email, password: String) async -> UUID? {
        do {
            let data = try await client.performAuthRequest(username: username.emailAdress, password: password)
            let token = try JSONMapping.jsonAuthDecoder(data) 
            return token
        } catch {
            return nil
        }
    }
}
