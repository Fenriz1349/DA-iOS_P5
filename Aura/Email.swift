//
//  Email.swift
//  Aura
//
//  Created by Julien Cotte on 28/11/2024.
//

import Foundation

// Même si ils sont autorisés dans certains cas, on partira du principe que les accents et caractères speciaux sont interdit.
// Pour eviter les erreurs de saisies lié au clavier mobile, et car la norme n'est pas d'utiliser les majuscules, toutes les saisies seront .lowercased()
class Email {
    let local: Local
    let domain: Domain
    
    init(local: Local, domain: Domain) {
        self.local = local
        self.domain = domain
    }
    
    var emailAdress : String {
        return local.name + "@" + domain.name + "." + domain.domExtension
    }
    
    /// Fonction qui verifie si une string est un adresse mail valide
    /// - Parameter string: la chaine à tester
    /// - Returns: true si c'et un email valide, false sinon
    static func isValid(_ string: String) -> Bool {
        return Email.from(string) != nil
    }
    
    /// Fonction pour convertir une String en Email
    /// - Parameter emailString: la string que l'ont veut convertir
    /// - Returns: cette String en email si elle rempli les condition, nil sinon
    static func from(_ emailString: String) -> Email? {
        let components = emailString.split(separator: "@", maxSplits: 1)
        guard components.count == 2 else {
            return nil
        }
        let localPart = String(components[0])
        let domainPart = String(components[1])
        
        let local = Local(name: localPart)
        let domain = Domain.from(domainPart)
        guard let domain = domain, domain.isValidDomain(), local.isValid() else { return nil }
        return Email(local: local, domain: domain)
    }
}

struct Local {
    let name: String
    
    init(name: String) {
        self.name = name.lowercased()
    }
    /// Fonction pour verifier si la partie local d'une adresse mail est valide
    /// - Returns: true si la string rempli les condition d'un nom de domaine, false sinon
    func isValid () -> Bool {
        // Ne doit pas depasser 64 caractère
        guard name.count <= 64 && !name.isEmpty else { return false }
        
        // Ne doit ni commencer, ni terminer par un point ou un tiret
        guard let first = name.first , first != ".", first != "-",
              let last = name.last, last != ".", last != "-" else {
            return  false
        }
        
        // Ne doit pas avoir 2 point consecutif, et doit contenir uniquement :
        // "A" à "Z", "a" à "z", "0" à "9" et les caractères à la fin
        guard !name.contains(",") else { return false }
        let localNameRegex = try! Regex("^(?!.*\\.\\.)[a-z0-9 .!#$%&'*+-/=?^_`{|}~]+$")
        return name.wholeMatch(of: localNameRegex) != nil
    }
}

struct Domain {
    let name: String
    let domExtension: String
    
    init(name: String, domExtension: String) {
        self.name = name.lowercased()
        self.domExtension = domExtension.lowercased()
    }
    
    /// Fonction pour tester si la partie nom de domain est valide
    /// - Returns: true si elle l'est, false sinon
    func isValidName () -> Bool {
        // Ne doit ni commencer, ni terminer par un point
        guard let first = name.first , first != ".", first != "-",
              let last = name.last, last != ".", last != "-"  else {
            return  false
        }
        // Ne doit contenir que des lettres min et maj et des chiffres, . et -
        let domainNameRegex = try! Regex("^(?!.*\\.\\.)[a-z0-9.-]+$")
        return name.wholeMatch(of: domainNameRegex) != nil
    }
    
    /// Fonction pour tester si l'extension de domain est valide
    /// - Returns: true si elle l'est, false sinon
    func isValidExtension () -> Bool {
        // l'extention de domaine doit avoir au moins 2 caractères et moins de 63
        guard domExtension.count >= 2 && domExtension.count <= 63 else { return false }
        // Elle ne doit comporter que des lettres, majuscules ou minuscule
        let domainExtensionRegex = try! Regex("[a-z]+$")
        return domExtension.wholeMatch(of:domainExtensionRegex) != nil
    }
    
    /// Fonction pour tester si le nom et l'extenstion de domaine sion valide
    /// - Returns: true si les deux le sont, false sinon
    func isValidDomain () -> Bool {
        return isValidName() && isValidExtension() && (name.count + domExtension.count <= 255)
    }
    
    /// Fonction pour créer un Domain à partir d'une String en les séparant depuis le dernier point
    /// - Parameter domainString: la String à convertir
    /// - Returns: le Domain si les 2 parties sont valides, nil sinon
    static func from(_ domainString: String) -> Domain? {
        if let lastDotIndex = domainString.lastIndex(of: ".") {
                let domainName = domainString[..<lastDotIndex]
                let domainExtension = domainString[lastDotIndex...].dropFirst()
                
                let domain = Domain(name: String(domainName), domExtension: String(domainExtension))
                
                return domain.isValidDomain() ? domain : nil
            }
        return nil
    }
}
