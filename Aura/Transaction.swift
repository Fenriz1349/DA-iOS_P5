//
//  Transaction.swift
//  Aura
//
//  Created by Julien Cotte on 28/11/2024.
//

import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    let description: String
    let amount: Double
}
