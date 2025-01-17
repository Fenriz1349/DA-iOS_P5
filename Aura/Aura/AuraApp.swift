//
//  AuraApp.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

@main
struct AuraApp: App {
    @StateObject var appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if appViewModel.isLogged,
                   let accountViewModel = appViewModel.accountViewModel,
                   let moneyTransferViewModel = appViewModel.moneyTransferViewModel {
                    TabView {
                        AccountView(accountViewModel: accountViewModel)
                            .tabItem {
                                Image(systemName: IconName.personCirle)
                                Text("account".localized)
                            }
                        MoneyTransferView(moneyTransferViewModel: moneyTransferViewModel)
                            .tabItem {
                                Image(systemName: IconName.leftRightArrowCircle)
                                Text("transfer".localized)
                            }
                    }
                } else {
                    AuthenticationView(authenticationViewModel: appViewModel.authenticationViewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity),
                                                removal: .move(edge: .top).combined(with: .opacity)))
                    
                }
            }
            .accentColor(.customGreen)
            .animation(.easeInOut(duration: 0.5), value: appViewModel.isLogged)
        }
    }
}
