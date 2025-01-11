//
//  AuthenticationView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        ZStack {
            CustomGradient()
            VStack(spacing: 20) {
                CustomImage(image: IconName.person, size: 50)
                Text("welcome".localized)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                CustomTextField(color: Color(UIColor.secondarySystemBackground),
                                placeholder: "mailAdress".localized,
                                text: $username,
                                type: .email)
                CustomTextField(color: Color(UIColor.secondarySystemBackground),
                                placeholder: "password".localized,
                                text: $password,
                                type: .password)
                Button(action: {
                    Task {
                        await viewModel.login(usermail: username, password: password)
                    }
                }) {
                    CustomButton(icon: nil, text: "login".localized, color: .black)
                }
                VStack {
                    if let message = viewModel.appViewModel.errorMessage {
                        ErrorLabel(message: message)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .task {
                                // Affiche le label pendant 5 secondes puis réinstalle la variable à false
                                try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
                                viewModel.appViewModel.hideErrorMessage()
                            }
                    }
                }
                .frame(height:40)
            }
            .padding(.horizontal, 40)
        }
        .onTapGesture {
            self.endEditing(true)
        }
    }
}

#Preview {
//    AuthenticationView(viewModel: AuthenticationViewModel(onLoginSucceed: , onLoginSucceed: {_ in }, appViewModel: AppViewModel()))
}
