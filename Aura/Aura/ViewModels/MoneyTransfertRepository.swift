//
//  MoneyTransfertRepository.swift
//  Aura
//
//  Created by Julien Cotte on 10/01/2025.
//

import Foundation

class MoneyTransfertRepository {
    private let client: HTTPClientMoneyTransfer
    
    init(client: HTTPClientMoneyTransfer = ConnectorMoneyTransfer()) {
        self.client = client
    }
    
    /// Permet de simuler un envoie d'argent
    /// - Parameters:
    ///   - username: le username du user
    ///   - recipient: le destinataire
    ///   - amount: le montant
    /// - Returns: true si performMoneySending renvoie true, false sinon
    func trySendMoney(username: String, recipient:String, amount: Decimal) async -> Bool {
        do {
            let result = try await client.performMoneySending(username: username, recipient: recipient, amount: amount)
            return result
        } catch {
            return false
        }
    }
}
