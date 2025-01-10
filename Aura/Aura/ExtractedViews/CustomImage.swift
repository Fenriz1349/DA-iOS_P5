//
//  CustomImage.swift
//  Aura
//
//  Created by Julien Cotte on 10/01/2025.
//

import SwiftUI

struct CustomImage: View {
    let image: String
    let size: CGFloat
    var color: Color = .black
    var isAnimated: Bool = false
    
    @State private var animationScale: CGFloat = 1.0
    
    var body: some View {
        let baseImage = Image(systemName: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(color)
            .padding()
        if isAnimated {
            baseImage
            .scaleEffect(animationScale)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    animationScale = 1.2
                }
            }
        } else {
            baseImage
        }
    }
}

#Preview {
    CustomImage(image: IconName.person,size: 50)
}
