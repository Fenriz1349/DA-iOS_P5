//
//  CustomButton.swift
//  Aura
//
//  Created by Julien Cotte on 10/01/2025.
//

import SwiftUI

struct CustomButton: View {
    let icon : String?
    let text : String
    let color : Color
    var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
            }
            Text(text)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

#Preview {
    CustomButton(icon: IconName.listBullet, text: "seeDetails".localized, color: .customGreen)
}
