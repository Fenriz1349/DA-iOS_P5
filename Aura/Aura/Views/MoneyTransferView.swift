//
//  MoneyTransferView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct MoneyTransferView: View {
    @ObservedObject var moneyTransferViewModel: MoneyTransferViewModel
    @State var recipient: String = ""
    @State var amount: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            CustomImage(image: IconName.leftRightArrowFill, size: 80, color: .accent, isAnimated: true)
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
                    await moneyTransferViewModel.sendMoney(recipient: recipient, amount: amount)
                    if moneyTransferViewModel.transferIsError {
                        Task {
                            // Affiche le label pendant 5 secondes puis réinstalle la variable à false
                            try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
                            moneyTransferViewModel.transferErrorMessage = nil
                            moneyTransferViewModel.transferIsError = true
                        }
                    }
                }
            })
            {
                CustomButton(icon: IconName.rigthArrow, message: "send".localized, color: .accentColor)
            }
            VStack {
                if let message = moneyTransferViewModel.transferErrorMessage {
                    InfoLabel(message: message, isError: moneyTransferViewModel.transferIsError)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .frame(height: 120)
        }
        .padding(.horizontal, 40)
        .onTapGesture {
            self.endEditing(true)
        }
    }
}

#Preview {
    MoneyTransferView(moneyTransferViewModel: MoneyTransferViewModel(repository: MoneyTransfertRepository(), appViewModel: AppViewModel()))
}
