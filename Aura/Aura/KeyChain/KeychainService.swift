//
//  KeychainService.swift
//  Aura
//
//  Created by Julien Cotte on 19/12/2024.
//

import Foundation
import Security

// L'ajout du protocol servira à override les fonctions pour les tests
protocol KeychainServiceProtocol {
    func save(key: String, data: Data) -> Bool
    func load(key: String) -> Data?
    func getToken(key: String) -> UUID?
    func delete(key: String)
}
// Le keychainService est à gérer des données sensibles comme le token
class KeychainService: KeychainServiceProtocol {
    
    /// Permet de sauvegarder une data associé à une key et d'effacer l'ancienne data si la clé existait déja
    /// - Parameters:
    ///   - key: la clé
    ///   - data: la data à enregistrer
    /// - Returns: true si le save s'est fait, faux sinon
    func save(key: String, data: Data) -> Bool {
        guard !key.isEmpty else {
            return false
        }
        guard let tokenString = String(data: data, encoding: .utf8),
              UUID(uuidString: tokenString) != nil else {
            return false
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    /// Permet de récuperer un token si on a la clé
    /// - Parameter key: la clé correspondant à la data
    /// - Returns: la data si elle existe, nil sinon
    func load(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess else {
            return nil
        }
        
        return dataTypeRef as? Data
    }
    
    
    /// Permet de supprimer la data d'une clé
    /// - Parameter key: la clé de la data à supprimer
    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
    
    
    /// Permet de recupérer le tokan associé à une clé
    /// - Parameter key: l'username du token
    /// - Returns: le token si la clé existe, nil sinon
    func getToken(key: String) -> UUID? {
        guard let data = load(key: key),
              let tokenString = String(data: data, encoding: .utf8),
              let token = UUID(uuidString: tokenString) else {
            return nil
        }
        return token
    }
}

