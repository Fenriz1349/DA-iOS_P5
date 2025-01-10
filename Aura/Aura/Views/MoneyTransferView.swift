//
//  MoneyTransferView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct MoneyTransferView: View {
    @ObservedObject var viewModel = MoneyTransferViewModel()
    
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
                            text: $viewModel.recipient,
                            type: .email)
            CustomTextField(color: Color.gray.opacity(0.2),
                            placeholder: "zero".localized,
                            header: "amount".localized,
                            text: $viewModel.amount,
                            type: .decimal)
            
            Button(action: viewModel.sendMoney) {
                CustomButton(icon: IconName.rigthArrow, text: "send".localized, color: .customGreen)
            }
            
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
