//
//  CreateRequest.swift
//  Aura
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation

// Le Connector pour gerer les appels réseaux
protocol HTTPClient {
    func performRequest(from url: URL, with method: HTTPMethod) async throws -> Data
}

class Connector: HTTPClient {
    private let session: URLSession
    // Ajout d'une init pour pouvoir injecter une URLSession pour les tests
    // .ephemeral permet de ne rien sauvegarder en cache
    init(session: URLSession = URLSession(configuration: .ephemeral)) {
        self.session = session
    }
    
    // Permet de créer la requete URL
    func createURLRequest(from url: URL, with method: HTTPMethod) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    // Permet d'executer une requete URL
    func executeDataRequest(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        
        // Vérifie que la réponse est bien de type HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, httpResponse)
    }
    
    // Permet de recuperer la data d'une requete URL
    func performRequest(from url: URL, with method: HTTPMethod) async throws -> Data {
        let request = try createURLRequest(from: url, with: method)
        let (data, httpResponse) = try await executeDataRequest(request)
        
        // Vérifie le code de réponse HTTP
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
