//
//  ErrorLabel.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import SwiftUI

// Affiche un message sur fond rouge
struct InfoLabel: View {
    let message : String
    let isError: Bool
    
    var body: some View {
            HStack {
                Image(systemName: isError ? IconName.exclamationMark : IconName.checkCircle )
                Text(message)
            }
            .padding()
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .background(isError ? .customRed : .customGreen)
            .cornerRadius(10)
        }
}

#Preview {
    InfoLabel(message: "Je suis un message d'erreur", isError: true)
}
