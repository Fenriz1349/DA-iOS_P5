//
//  AuthenticationView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject var viewModel = AppViewModel().authenticationViewModel
    @State private var username: String = ""
    @State private var password: String = ""
    
    let gradientStart = Color(hex: "#94A684").opacity(0.7)
    let gradientEnd = Color(hex: "#94A684").opacity(0.0) // Fades to transparent
    var body: some View {
        
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]), startPoint: .top, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text("Welcome !")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                TextField("Adresse email", text: $username)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                
                SecureField("Mot de passe", text: $password)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                
                Button(action: {
                    Task {
                            do {
                                try await viewModel.login(usermail: username, password: password)
                            } catch {
                                print("Erreur lors de la connexion : \(error.localizedDescription)")
                            }
                        }
                }) {
                    Text("Se connecter")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(8)
                }
                VStack {
                    if viewModel.showError,
                       let message = viewModel.errorMessage {
                        ErrorLabel(message: message)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .task {
                                // Affiche le label pendant 5 secondes puis réinstalle la variable à false
                                try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
                                viewModel.hideErrorMessage()
                            }
                    }
                }
                .frame(height:40)
            }
            .padding(.horizontal, 40)
        }
        .onTapGesture {
            self.endEditing(true)  // This will dismiss the keyboard when tapping outside
        }
    }
}

#Preview {
    AuthenticationView(viewModel: AuthenticationViewModel({
        
    }))
}
