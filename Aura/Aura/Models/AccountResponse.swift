//
//  AccountResponse.swift
//  Aura
//
//  Created by Julien Cotte on 27/12/2024.
//

import Foundation

// struct de la data récupérée avec le token d'un User
struct AccountResponse: Codable {
    let currentBalance: Double
    let transactions: [Transaction]
}

