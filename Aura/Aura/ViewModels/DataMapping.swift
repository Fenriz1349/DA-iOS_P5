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
    static func JSONAuthEncoder(username: String, password: String) -> Data {
        let encoder = JSONEncoder()
        let loginData = [
            "username": username,
            "password": password
        ]
        return try! encoder.encode(loginData)
    }
    
    static func JSONAuthDecoder(_ data: Data) -> UUID? {
        // Décodage de la réponse JSON
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode([String: String].self, from: data)
            
            // Récupération du token
            if let tokenString = decodedResponse["token"], let token = UUID(uuidString: tokenString) {
                return token
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
