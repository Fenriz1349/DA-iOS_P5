//
//  AuthentificationRepository.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import Foundation

struct AuthentificationRepository {
    // static pour pouvoir utiliser cette constante sans créer d'instance
    static let urlVapor = "http://127.0.0.1:8080"
    static let urlVaporAuthen = urlVapor + "/auth"
    private let executeDataRequest: (URLRequest) async throws -> (Data, URLResponse)
    
    init(executeDataRequest: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)) {
        self.executeDataRequest = executeDataRequest
    }
    
    func tryGet () async throws -> String? {
        guard let url = URL(string: AuthentificationRepository.urlVapor) else {
            throw URLError(.badURL)
        }
        let request = try URLRequest( url: url, method: .GET )
        let (data, response) = try await executeDataRequest(request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return String(data: data, encoding: .utf8)
    }
    
    func getTokenFrom(_ user: User) async throws -> UUID? {
        guard let url = URL(string: AuthentificationRepository.urlVaporAuthen) else {
            throw URLError(.badURL)
        }
        // Dictionnaire qui sera converti en JSON pour l'authentification
        let loginData = [
            "username": user.userEmail.emailAdress,
            "password": user.userPassword
        ]
        let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
        // Création de la requete, en methode Post
        var request = try URLRequest( url: url, method: .POST )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let (data, response) = try await executeDataRequest(request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        // Décodage de la réponse JSON
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode([String: String].self, from: data)
            
            // Récupération du token
            if let tokenString = decodedResponse["token"], let token = UUID(uuidString: tokenString) {
                return token
            } else {
                throw URLError(.cannotParseResponse)
            }
        } catch {
            throw error
        }
    }
}
