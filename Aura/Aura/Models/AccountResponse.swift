//
//  AccountResponse.swift
//  Aura
//
//  Created by Julien Cotte on 27/12/2024.
//

import Foundation

struct AccountResponse: Codable {
    let currentBalance: Double
    let transactions: [Transaction]
}

