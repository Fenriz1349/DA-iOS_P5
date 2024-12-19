//
//  CreateRequest.swift
//  Aura
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation

// Le Connector ne va s'occuper que de gèrer les appels réseaux
// Il sera de protocol HTTPCLient qui garanti qu'il aura toujours la fonction performRequest
protocol HTTPClient {
    func performRequest(from url: URL, with method: HTTPMethod) async throws -> Data
    func performAuthRequest(username: String, password: String, url: URL) async throws -> Data
}

struct Connector : HTTPClient {
    private let session: URLSession
    // Ajout d'une init pour pouvoir injecter une URLSession pour les tests
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func createURLRequest(from url: URL, with method: HTTPMethod) throws -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            return request
        }
        
    func executeDataRequest(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        
        // Vérifie que la réponse est bien de type HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, httpResponse)
    }
    
    func performRequest(from url: URL, with method: HTTPMethod) async throws -> Data {
        let request = try createURLRequest(from: url, with: method)
        let (data, httpResponse) = try await executeDataRequest(request)
        
        // Vérifie le code de réponse HTTP
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
    
    func performAuthRequest(username: String, password: String, url: URL) async throws -> Data {
        // Créer la requête POST
        let body = JSONMapping.JSONAuthEncoder(username: username, password: password)
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
