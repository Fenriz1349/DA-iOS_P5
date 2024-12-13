//
//  AuthentificationRepository.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import Foundation

struct AuthenticationRepository {
    private let executeDataRequest: (URLRequest) async throws -> Data
    
    init(executeDataRequest: @escaping (URLRequest) async throws -> Data = { request in
        try await Connector.performRequest(from: request.url!, with: HTTPMethod(rawValue: request.httpMethod!)!)
        }) {
            self.executeDataRequest = executeDataRequest
        }
    
    // Fonction pour tester la connexion avec le serveur et traiter tous les cas d'erreur.
    // Si la connexion est bonne renvoie "It works!"
    func tryGet(url: URL = AppConfig().baseUrl) async -> Bool {
        let expectedData = "It works!"
        guard let data = try? await Connector.performRequest(from: url, with: .GET) else {
            return false
        }
        // Verifie que la data recu
        guard let stringResponse = DataMapping.getStringFrom(data) else {
            return false
        }
        // Vérification si le contenu est bien "It Works!"
        return stringResponse == expectedData
    }
    
// construire les URL à part
    // sortir la partie decodage et encodage
    func getTokenFrom(username: Email, password: String, url: URL = AppConfig().authURL) async throws -> UUID? {
        // Dictionnaire qui sera converti en JSON pour l'authentification
        let loginData = [
            "username": username.emailAdress,
            "password": password
        ]
        // changer pour json encoder
        let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
        // Création de la requete, en methode Post
        var request = try URLRequest( url: url, method: .POST )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let data = try await executeDataRequest(request)
        
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
        } catch is DecodingError {
            throw URLError(.cannotDecodeContentData)
        }
    }
}
