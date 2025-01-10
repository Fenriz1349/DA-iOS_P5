//
//  AccountRepository.swift
//  Aura
//
//  Created by Julien Cotte on 20/12/2024.
//

import Foundation

class AccountRepository {
    let client : HTTPClientAccount
    
    init(client: HTTPClientAccount = ConnectorAccount()) {
        self.client = client
    }
    
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
