//
//  CustomButton.swift
//  Aura
//
//  Created by Julien Cotte on 10/01/2025.
//

import SwiftUI

// Bouton qui affiche un Text avec optionnellement une Icone avant
struct CustomButton: View {
    let icon : String?
    let message : String
    let color : Color
    var body: some View {
        HStack {
            if let icon = icon { Image(systemName: icon) }
            Text(message)
        }
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .padding()
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.4), radius: 6, x: -4, y: -4)
        .shadow(color: .black.opacity(0.2), radius: 6, x: 4, y: 4)
    }
}

#Preview {
    CustomButton(icon: IconName.listBullet, message: "seeDetails".localized, color: .accentColor)
}
