//
//  AccountHeader.swift
//  Aura
//
//  Created by Julien Cotte on 27/12/2024.
//

import SwiftUI

struct AccountHeader: View {
    let balance: Double
    var body: some View {
        VStack(spacing: 10) {
            Text("Your Balance")
                .font(.headline)
            Text(balance.toEuroFormat())
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(Color(hex: "#94A684")) // Using the green color you provided
        }
        .padding(.top)
    }
}

#Preview {
    AccountHeader(balance: 666.66)
}
