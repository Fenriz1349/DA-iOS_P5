//
//  AuraTestMoneyTransferRepository.swift
//  AuraTests
//
//  Created by Julien Cotte on 21/01/2025.
//

import XCTest
@testable import Aura

class AuraTestsMoneyTransfertRepository: XCTestCase {
    
    // MARK: - MoneyTransfertRepository Tests
    
    func testTrySendMoney_success() async {
        // Given
        let mockClient = MockHTTPClientMoneyTransfer()
        mockClient.isPerformSucess = true 
        let repository = MoneyTransfertRepository(client: mockClient)
        
        // When
        let result = await repository.trySendMoney(username: "user@example.com", recipient: "recipient@example.com", amount: 100.0)
        
        // Then
        XCTAssertTrue(result)
    }

    func testTrySendMoney_failure() async {
        // Given
        let mockClient = MockHTTPClientMoneyTransfer()
        mockClient.isPerformSucess = false
        let repository = MoneyTransfertRepository(client: mockClient)
        
        // When
        let result = await repository.trySendMoney(username: "user@example.com", recipient: "recipient@example.com", amount: 100.0)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testTrySendMoney_error() async {
        // Given
        let mockClient = MockHTTPClientMoneyTransfer()
        mockClient.mockError = URLError(.notConnectedToInternet)
        let repository = MoneyTransfertRepository(client: mockClient)
        
        // When
        let result = await repository.trySendMoney(username: "user@example.com", recipient: "recipient@example.com", amount: 100.0)
        
        // Then
        XCTAssertFalse(result)
    }
}
