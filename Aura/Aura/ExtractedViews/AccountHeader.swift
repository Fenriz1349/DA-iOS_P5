//
//  AccountHeader.swift
//  Aura
//
//  Created by Julien Cotte on 27/12/2024.
//

import SwiftUI

// Header contenant le titre et un montant en Euro
struct AccountHeader: View {
    let balance: Double
    var body: some View {
        VStack(spacing: 10) {
            Text("headerTitle".localized)
                .font(.headline)
            Text(balance.toEuroFormat())
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.accent)
        }
        .padding(.top)
    }
}

#Preview {
    AccountHeader(balance: 666.66)
}
