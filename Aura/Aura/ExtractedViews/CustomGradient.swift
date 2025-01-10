//
//  CustomGradient.swift
//  Aura
//
//  Created by Julien Cotte on 10/01/2025.
//

import SwiftUI

struct CustomGradient: View {
    let gradientStart = Color(.customGreen).opacity(0.7)
    let gradientEnd = Color(.customGreen).opacity(0.0)
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]), startPoint: .top, endPoint: .bottomLeading)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CustomGradient()
}
