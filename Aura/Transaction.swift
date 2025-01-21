//
//  Transaction.swift
//  Aura
//
//  Created by Julien Cotte on 28/11/2024.
//

import Foundation

// Une Transaction, avec son intitulé et sa valeur
struct Transaction: Codable, Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}
