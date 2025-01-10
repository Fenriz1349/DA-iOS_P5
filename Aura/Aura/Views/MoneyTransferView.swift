//
//  MoneyTransferView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct MoneyTransferView: View {
    @ObservedObject var viewModel = MoneyTransferViewModel()

        @State private var animationScale: CGFloat = 1.0

        var body: some View {
            VStack(spacing: 20) {
                // Adding a fun header image
                Image(systemName: Icons.leftRightArrow)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.customGreen)
                    .padding()
                    .scaleEffect(animationScale)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                            animationScale = 1.2
                        }
                    }
                
                Text(Texts.sendMoney)
                    .font(.largeTitle)
                    .fontWeight(.heavy)

                VStack(alignment: .leading) {
                    Text(Texts.recipient)
                        .font(.headline)
                    TextField(Texts.recipientInfo, text: $viewModel.recipient)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                }
                
                VStack(alignment: .leading) {
                    Text(Texts.amount)
                        .font(.headline)
                    TextField(Texts.zero, text: $viewModel.amount)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .keyboardType(.decimalPad)
                }

                Button(action: viewModel.sendMoney) {
                    HStack {
                        Image(systemName: Icons.rigthArrow)
                        Text(Texts.send)
                    }
                    .padding()
                    .background(.customGreen)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())

                // Message
                if !viewModel.transferMessage.isEmpty {
                    Text(viewModel.transferMessage)
                        .padding(.top, 20)
                        .transition(.move(edge: .top))
                }
                
                Spacer()
            }
            .padding()
            .onTapGesture {
                        self.endEditing(true)  
                    }
        }
}


#Preview {
    MoneyTransferView()
}
