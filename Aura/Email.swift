//
//  Email.swift
//  Aura
//
//  Created by Julien Cotte on 28/11/2024.
//

import Foundation
// Même si ils sont autorisé dans certains cas, on partira du principe que les accents et caractères speciaux sont interdit
class Email {
    let local: Local
    let domain: Domain
    
    init(local: Local, domain: Domain) {
        self.local = local
        self.domain = domain
    }
    
    // fonction qui verifie si une string est un adresse mail valide
    static func isValidEmail(_ email: String) -> Bool {
        return Email.from(email) != nil
    }
    
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
    // fonction pour verifier si la partie local d'une adresse mail est valide
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
        let localNameRegex = try! Regex("^(?!.*\\.\\.)[A-Za-z0-9 .!#$%&'*+-/=?^_`{|}~]+$")
        return name.wholeMatch(of: localNameRegex) != nil
    }
}

struct Domain {
    let name: String
    let domExtension: String
    
    func isValidName () -> Bool {
        // Ne doit ni commencer, ni terminer par un point
        guard let first = name.first , first != ".", first != "-",
              let last = name.last, last != ".", last != "-"  else {
            return  false
        }
        // Ne doit contenir que des lettres min et maj et des chiffres, . et -
        let domainNameRegex = try! Regex("^(?!.*\\.\\.)[A-Za-z0-9.-]+$")
        return name.wholeMatch(of: domainNameRegex) != nil
    }
    
    func isValidExtension () -> Bool {
        // l'extention de domaine doit avoir au moins 2 caractères et moins de 63
        guard domExtension.count >= 2 && domExtension.count <= 63 else { return false }
        // Elle ne doit comporter que des lettres, majuscules ou minuscule
        let domainExtensionRegex = try! Regex("[A-Za-z]+$")
        return domExtension.wholeMatch(of:domainExtensionRegex) != nil
    }
    
    func isValidDomain () -> Bool {
        return isValidName() && isValidExtension() && (name.count + domExtension.count <= 255)
    }
    
    // Créer un nom de domaine à partir d'une String
    // separe à partir du dernier point pour avoir l'extension
    // renvoie nil si la string n'est pas valide
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
