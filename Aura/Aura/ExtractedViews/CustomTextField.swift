//
//  CustomTextField.swift
//  Aura
//
//  Created by Julien Cotte on 10/01/2025.
//

import SwiftUI

enum TextFieldType {
    case email
    case password
    case decimal
}

// Permet de gérer l'affichage de tous les Textfields de l'app suivant leur type
struct CustomTextField: View {
    let color: Color
    let placeholder: String
    var header: String? = nil
    @Binding var text: String
    let type: TextFieldType
    
    var body: some View {
        let (keyboardType, isSecure, disableAutocorrection) = configureTextField(type: type)
        
        VStack(alignment: .leading) {
            if let header = header {
                Text(header)
                    .font(.headline)
            }
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(color: color)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled(disableAutocorrection)
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(color: color)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled(disableAutocorrection)
                    .autocapitalization(type == .email ? .none : .sentences)
            }
        }
    }
}

extension CustomTextField {
    func configureTextField(type: TextFieldType) -> (UIKeyboardType, Bool, Bool) {
        switch type {
        case .email: return (.emailAddress, false, true)
        case .password: return (.default, true, false)
        case .decimal: return (.decimalPad, false, false)
        }
    }
}
