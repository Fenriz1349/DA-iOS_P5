//
//  AuthenticationView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
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
                        await authenticationViewModel.login(username: username, password: password)
                        await authenticationViewModel.appViewModel.accountViewModel?.updateAppUser()
                    }
                }) {
                    CustomButton(icon: nil, message: "login".localized, color: .black)
                }
                VStack {
                    if let message = authenticationViewModel.authenticationErrorMessage {
                        InfoLabel(message: message, isError: authenticationViewModel.autenticationIsError)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .task {
                                // Affiche le label pendant 5 secondes puis réinstalle la variable à false
                                try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
                                authenticationViewModel.authenticationErrorMessage  = nil
                            }
                    }
                }
                .frame(height:80)
            }
            .padding(.horizontal, 40)
        }
        .onTapGesture {
            self.endEditing(true)
        }
    }
}

#Preview {
    AuthenticationView(authenticationViewModel: AuthenticationViewModel(
        onLoginSucceed: { user in
            print("Utilisateur connecté")
        },
        appViewModel: AppViewModel()))
}
