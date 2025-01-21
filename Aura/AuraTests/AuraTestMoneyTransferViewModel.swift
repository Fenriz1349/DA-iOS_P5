//
//  AuraTestMoneyTransferViewModel.swift
//  AuraTests
//
//  Created by Julien Cotte on 21/01/2025.
//

import XCTest
@testable import Aura

class AuraTestsMoneyTransferViewModel: XCTestCase {
    
    // MARK: - MoneyTransferViewModel Tests
    
    func testSendMoney_invalidRecipient() async {
        // Given
        let mockRepository = MockMoneyTransfertRepository()
        let mockAppViewModel = await AppViewModel()
        let viewModel = await MoneyTransferViewModel(repository: mockRepository, appViewModel: mockAppViewModel)
        
        // When
        await viewModel.sendMoney(recipient: "invalid-recipient", amount: "100.0")
        
        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.transferIsError)
            XCTAssertEqual(viewModel.transferErrorMessage, "wrongRecipient".localized)
        }
    }

    func testSendMoney_invalidAmount() async {
        // Given
        let mockRepository = MockMoneyTransfertRepository()
        let mockAppViewModel = await AppViewModel()
        let viewModel = await MoneyTransferViewModel(repository: mockRepository, appViewModel: mockAppViewModel)
        
        // When
        await viewModel.sendMoney(recipient: "valid.email@example.com", amount: "invalidAmount")
        
        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.transferIsError)
            XCTAssertEqual(viewModel.transferErrorMessage, "wrongAmmount".localized)
        }
    }
    
    func testSendMoney_success() async {
        // Given
        let mockRepository = MockMoneyTransfertRepository()
        mockRepository.isTransferSucess = true
        let mockAppViewModel = await AppViewModel()
        let viewModel = await MoneyTransferViewModel(repository: mockRepository, appViewModel: mockAppViewModel)
        
        // When
        await viewModel.sendMoney(recipient: "recipient@example.com", amount: "100.0")
        
        // Then
        await MainActor.run {
            XCTAssertFalse(viewModel.transferIsError)
            XCTAssertEqual(viewModel.transferErrorMessage, String(format: NSLocalizedString("transferSucess".localized, comment: ""), "100,00€", "recipient@example.com"))
        }
    }

    func testSendMoney_failure() async {
        // Given
        let mockRepository = MockMoneyTransfertRepository()
        mockRepository.isTransferSucess = false // Simuler un échec de transfert d'argent
        let mockAppViewModel = await AppViewModel()
        let viewModel = await MoneyTransferViewModel(repository: mockRepository, appViewModel: mockAppViewModel)
        
        // When
        await viewModel.sendMoney(recipient: "recipient@example.com", amount: "100.0")
        
        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.transferIsError)
            XCTAssertEqual(viewModel.transferErrorMessage, "transferFail".localized)
        }
    }
}
