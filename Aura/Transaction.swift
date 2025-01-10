//
//  Transaction.swift
//  Aura
//
//  Created by Julien Cotte on 28/11/2024.
//

import Foundation

struct Transaction: Codable, Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}
