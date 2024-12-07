//
//  CreateRequest.swift
//  Aura
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation

struct Connector {
    // Ajout de URLSession injectable pour les tests
    static var session: URLSession = URLSession.shared
    
    static func createURLRequest(from url: URL, with method: HTTPMethod) throws -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            return request
        }
        
    static func executeDataRequest(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: request)
        
        // Vérifie que la réponse est bien de type HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, httpResponse)
    }
    
    static func performRequest(from url: URL, with method: HTTPMethod) async throws -> Data {
        let request = try createURLRequest(from: url, with: method)
        let (data, httpResponse) = try await executeDataRequest(request)
        
        // Vérifie le code de réponse HTTP
        guard httpResponse.statusCode == 200 else {
            throw URLError(.cannotConnectToHost)
        }
        return data
    }
}
