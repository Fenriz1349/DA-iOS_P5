//
//  ConnectorAuthentication.swift
//  Aura
//
//  Created by Julien Cotte on 20/12/2024.
//

import Foundation

// Le protocol HTTPCLient qui garanti qu'il aura toujours la fonction performAuthRequest
protocol HTTPClientAuthentication: HTTPClient {
    func performAuthRequest(username: String, password: String) async throws -> Data
}

// Connector qui gère l'appel reseau pour recupéré le token d'un user pour le login
class ConnectorAuthentication: Connector, HTTPClientAuthentication {
    ///  Renvoie la data lié à un unsername et un password
    /// - Parameters:
    ///   - username:username du user
    ///   - password: password du user
    /// - Returns: le token du user dans un Json
    func performAuthRequest(username: String, password: String) async throws -> Data {
        // Créer la requête POST
        let url = AppConfig().authURL
        let body = JSONMapping.jsonAuthEncoder(username: username, password: password)
        var request = try createURLRequest(from: url, with: .POST)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        // Renvoyer les données brutes
        let (data, httpResponse) = try await executeDataRequest(request)
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
