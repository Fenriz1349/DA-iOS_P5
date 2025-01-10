//
//  ErrorLabel.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import SwiftUI

// Affiche un message sur fond rouge
struct ErrorLabel: View {
    var message : String
    
    var body: some View {
            Text("⚠ \(message)")
                .padding(5)
                .foregroundStyle(.white)
                .background(Color.red)
                .cornerRadius(10)
    }
}

#Preview {
    ErrorLabel(message: "Je suis un message d'erreur")
}
