//
//  MoneyTransferView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct MoneyTransferView: View {
    @ObservedObject var viewModel: MoneyTransferViewModel
    @State var recipient: String = ""
    @State var amount: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Adding a fun header image
            CustomImage(image: IconName.leftRightArrowFill, size: 80, color: .customGreen, isAnimated: true)
            Text("sendMoney".localized)
                .font(.largeTitle)
                .fontWeight(.heavy)
            CustomTextField(color: Color.gray.opacity(0.2),
                            placeholder: "recipientInfo".localized,
                            header: "recipient".localized,
                            text: $recipient,
                            type: .email)
            CustomTextField(color: Color.gray.opacity(0.2),
                            placeholder: "zero".localized,
                            header: "amount".localized,
                            text: $amount,
                            type: .decimal)
            
            Button(action: {
                Task{
                    await viewModel.sendMoney(recipient: recipient, amount: amount.toDecimal())
                }
            })
            {
                CustomButton(icon: IconName.rigthArrow, text: "send".localized, color: .customGreen)
            }
#warning("configurer le message de reussite ou echec")
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
            
            Spacer()
        }
        .padding()
        .onTapGesture {
            self.endEditing(true)
        }
    }
}

#Preview {
//    MoneyTransferView()
}
