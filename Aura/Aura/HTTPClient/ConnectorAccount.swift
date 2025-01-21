//
//  ConnectorAccount.swift
//  Aura
//
//  Created by Julien Cotte on 20/12/2024.
//

import Foundation

protocol HTTPClientAccount: HTTPClient {
    func performGetAccount(username: String) async throws -> Data
}

// Connector pour récupérer la currentBalance et la liste des Transactions d'un user
class ConnectorAccount: Connector, HTTPClientAccount {
    private let keychainService: KeychainServiceProtocol
    
    init(session: URLSession = URLSession(configuration: .ephemeral),
             keychainService: KeychainServiceProtocol = KeychainService()) {
            self.keychainService = keychainService
            super.init(session: session)
        }
    
    /// Permet de récupérer le currentBalance et les transactions d'un user
    /// - Parameter username: username du user
    /// - Returns: la data dans un Json
    func performGetAccount(username: String) async throws -> Data {
        // Récuperation du token dans le keychainService
        let tokenKeychain = KeychainService()
        guard let token = tokenKeychain.getToken(key: username) else {
            throw URLError(.userAuthenticationRequired)
        }
        // Créer la requête Get avec le token en Header
        let url = AppConfig().accountURL
        var request = try createURLRequest(from: url, with: .GET)
        request.setValue(token.uuidString, forHTTPHeaderField: "token")
        
        // Renvoyer les données brutes
        let (data, httpResponse) = try await executeDataRequest(request)
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}

