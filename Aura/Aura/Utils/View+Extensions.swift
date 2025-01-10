//
//  View+Extensions.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

extension View {
    func endEditing(_ force: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { $0.endEditing(force) }
        }
    }
    
    func textFieldStyle(color: Color) -> some View {
            self
                .padding()
                .background(color)
                .cornerRadius(8)
                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
        }
}
