//
//  SucessLabel.swift
//  Aura
//
//  Created by Julien Cotte on 10/01/2025.
//

import SwiftUI

// Affiche un message sur fond rouge
struct SucessLabel: View {
    var message : String
    
    var body: some View {
            Text(message)
                .padding(10)
                .foregroundStyle(.white)
                .background(Color(.customGreen))
                .cornerRadius(10)
    }
}

#Preview {
    ErrorLabel(message: "Je suis un message de Réussite")
}
