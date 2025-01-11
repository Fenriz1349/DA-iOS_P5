//
//  AuraApp.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

@main
struct AuraApp: App {
    @StateObject var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if viewModel.isLogged,
                   let accountViewModel = viewModel.accountViewModel,
                   let moneyTransferViewModel = viewModel.moneyTransferViewModel {
                    TabView {
                        AccountView(viewModel: accountViewModel)
                            .tabItem {
                                Image(systemName: IconName.personCirle)
                                Text("account".localized)
                            }
                        
                        MoneyTransferView(viewModel: moneyTransferViewModel)
                            .tabItem {
                                Image(systemName: IconName.leftRightArrowCircle)
                                Text("transfer".localized)
                            }
                    }
                    
                } else {
                    AuthenticationView(viewModel: viewModel.authenticationViewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity),
                                                removal: .move(edge: .top).combined(with: .opacity)))
                    
                }
            }
            .accentColor(.customGreen)
            .animation(.easeInOut(duration: 0.5), value: viewModel.isLogged)
        }
    }
}
