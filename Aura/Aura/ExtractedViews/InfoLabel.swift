//
//  ErrorLabel.swift
//  Aura
//
//  Created by Julien Cotte on 29/11/2024.
//

import SwiftUI

// Permet d'afficher un Text :
// - sur fond rouge avec un point d'exclamation si c'est une erreur
// - sur fond vert avec un check si ce n'est pas une erreur
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
            .background(isError ? .customRed : .accent)
            .cornerRadius(10)
        }
}

#Preview {
    InfoLabel(message: "Je suis un message d'erreur", isError: true)
}
