//
//  AuthentificationRepository.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import Foundation

// Le repository ne s'occupe que de récuperer les data du Connector pour les mapper avec la logique métier
class AuthenticationRepository {
    private let client: HTTPClient
    
    init(client: HTTPClient = Connector()) {
            self.client = client
        }
    
    // Fonction pour tester la connexion avec le serveur et traiter tous les cas d'erreur.
    // Si la connexion est bonne elle renvoie "It works!"
    func tryGet(url: URL = AppConfig().baseUrl) async -> Bool {
            let expectedData = "It works!"
            do {
                let data = try await client.performRequest(from: url, with: .GET)
                guard let stringResponse = DataMapping.getStringFrom(data) else {
                    return false
                }
                return stringResponse == expectedData
            } catch {
                return false
            }
        }
    
    // todo construire les URL à part
    // todo sortir la partie decodage et encodage
//    func getTokenFrom(username: Email, password: String, url: URL = AppConfig().authURL) async throws -> UUID? {
//        // Dictionnaire qui sera converti en JSON pour l'authentification
//        let loginData = [
//            "username": username.emailAdress,
//            "password": password
//        ]
//        // changer pour json encoder
//        let jsonData = try JSONSerialization.data(withJSONObject: loginData, options: [])
//        // Création de la requete, en methode Post
//        var request = try URLRequest( url: url, method: .POST )
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//        let data = try await executeDataRequest(request)
//        
//        // Décodage de la réponse JSON
//        let decoder = JSONDecoder()
//        do {
//            let decodedResponse = try decoder.decode([String: String].self, from: data)
//            
//            // Récupération du token
//            if let tokenString = decodedResponse["token"], let token = UUID(uuidString: tokenString) {
//                return token
//            } else {
//                throw URLError(.cannotParseResponse)
//            }
//        } catch is DecodingError {
//            throw URLError(.cannotDecodeContentData)
//        }
//    }
}
