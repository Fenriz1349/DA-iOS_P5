//
//  ConnectorAuthentication.swift
//  Aura
//
//  Created by Julien Cotte on 20/12/2024.
//

import Foundation

// Il sera de protocol HTTPCLient qui garanti qu'il aura toujours la fonction performAuthRequest
protocol HTTPClientAuthentication: HTTPClient {
    func performAuthRequest(username: String, password: String) async throws -> Data
}

class ConnectorAuthentication: Connector, HTTPClientAuthentication {
    
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
