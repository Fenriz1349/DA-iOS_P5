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
    func delete(key: String)
}
// Le keychainService est à gérer des données sensibles comme le token
class KeychainService: KeychainServiceProtocol {
    
    // Permet d'enregistrer un nouveau token et de supprimer l'ancienne valeur si elle existe
    // ce token doit forcemet être au format UUID
    func save(key: String, data: Data) -> Bool {
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
    
    // Permet de récuperer un token si on a la clé
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
    
    // Permet de supprimer une clé
    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}

