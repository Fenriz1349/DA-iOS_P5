//
//  ConnectorMoneyTransfer.swift
//  Aura
//
//  Created by Julien Cotte on 10/01/2025.
//

import Foundation

protocol HTTPClientMoneyTransfer: HTTPClient {
    func performMoneySending(username: String, recipient: String, amount: Decimal) async throws -> Bool
}

class ConnectorMoneyTransfer: Connector, HTTPClientMoneyTransfer {
    
    private let keychainService: KeychainServiceProtocol
    
    init(session: URLSession = URLSession(configuration: .ephemeral),
             keychainService: KeychainServiceProtocol = KeychainService()) {
            self.keychainService = keychainService
            super.init(session: session)
        }
    
    func performMoneySending(username: String, recipient: String, amount: Decimal) async throws -> Bool {
        // Créer la requête POST
        let url = AppConfig().moneyURL
        
        let tokenKeychain = KeychainService()
        guard let token = tokenKeychain.getToken(key: username) else {
            throw URLError(.userAuthenticationRequired)
        }
        let body = JSONMapping.jsonMoneyEncoder(recipient: recipient, amount: amount)
        var request = try createURLRequest(from: url, with: .POST)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token.uuidString, forHTTPHeaderField: "token")
        request.httpBody = body
        
        // La reponse est vide, mais on reçoit le statusCode 200 en cas de réussite
        let (_, httpResponse) = try await executeDataRequest(request)
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return true
    }
}
