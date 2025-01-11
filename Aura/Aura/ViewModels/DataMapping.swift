//
//  JSONEncoding.swift
//  Aura
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation

struct DataMapping {
    // retourn la data sous forme de string si elle et bien codé en utf8
    static func getStringFrom(_ data: Data) -> String? {
        guard let stringResponse = String(data: data, encoding: .utf8) else {
            return nil
        }
        return stringResponse
    }
}

struct JSONMapping {
    /// Fonction pour encoder le username et le password pour créer le body pour le login
    /// - Parameters:
    ///   - username: email de l'utilisateur
    ///   - password: mot de passe de l'utilisateur
    /// - Returns: le body qui servira à construire l'urlRequest
    static func jsonAuthEncoder(username: String, password: String) -> Data {
        let encoder = JSONEncoder()
        let loginData = [
            "username": username,
            "password": password
        ]
        return try! encoder.encode(loginData)
    }
    
    /// Fonction pour decoder la data reçu lors de la connexion et renvoyer le token
    /// - Parameter data: la data reçu du serveur
    /// - Returns: le token créé lors de la connexion
    static func jsonAuthDecoder(_ data: Data) throws -> UUID {
        // Décodage de la réponse JSON
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode([String: String].self, from: data)
            
            // Récupération du token
            if let tokenString = decodedResponse["token"], let token = UUID(uuidString: tokenString) {
                return token
            } else {
                throw URLError(.cannotDecodeContentData)
            }
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
    }
    
    /// Permet de decoder la reponse du serveur qui contient les données lié au compte
    /// - Parameters:
    ///   - data: la data sous forme de json
    /// - Returns: la donnée decodé au format AccountResponse
    static func jsonAccountDecoder(_ data: Data) throws -> AccountResponse {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(AccountResponse.self, from: data)

        } catch {
            throw URLError(.cannotDecodeContentData)
        }
    }
    
    /// Fonction pour encoder le username et le password pour créer le body pour le login
    /// - Parameters:
    ///   - username: email de l'utilisateur
    ///   - password: mot de passe de l'utilisateur
    /// - Returns: le body qui servira à construire l'urlRequest
    static func jsonMoneyEncoder(recipient: String, amount: Decimal) -> Data {
        let moneyData = [
            "recipient": recipient,
            "amount": amount
        ] as [String: Any]
        return try! JSONSerialization.data(withJSONObject: moneyData, options: [])
    }
}
