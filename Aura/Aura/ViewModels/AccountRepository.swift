//
//  AccountRepository.swift
//  Aura
//
//  Created by Julien Cotte on 20/12/2024.
//

import Foundation

class AccountRepository {
    private let client : HTTPClientAccount
    
    init(client: HTTPClientAccount = ConnectorAccount()) {
        self.client = client
    }
    
    /// Permet de récupérer les données du comptes d'un utillisateur, ici la currentBalance et la liste des transactions
    /// - Parameter username: le username dont on veut récupérer les données
    /// - Returns: la reponse si le username est valide, nil sinon
    func getAccountResponse(from username: String) async -> AccountResponse? {
        do {
            let data = try await client.performGetAccount(username: username)
            let response = try JSONMapping.jsonAccountDecoder(data)
            return response
        } catch {
            return nil
        }
    }
}
