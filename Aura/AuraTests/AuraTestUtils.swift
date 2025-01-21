//
//  AuraTestUtils.swift
//  AuraTests
//
//  Created by Julien Cotte on 17/01/2025.
//

import Foundation
import XCTest
@testable import Aura

class AuraTestsUtils: XCTestCase {
    // MARK: - User
    func testUpdateUser() {
        // Given
        let user = User(username: "default@example.com")
        let accountResponse: AccountResponse = User.defaultAccountResponse
        
        // When
        user.updateUser(from: accountResponse)
        
        // Then
        XCTAssertEqual(user.username, "default@example.com")
        XCTAssertEqual(user.currentBalance, User.defaultAccountResponse.currentBalance)
        XCTAssertEqual(user.transactions[0].value, User.defaultAccountResponse.transactions[0].value)
        XCTAssertEqual(user.transactions[0].label, User.defaultAccountResponse.transactions[0].label)
    }
    
    // MARK: - Transaction
    func testGetRecentTransactions() {
        // Given
        let transactions: [Transaction] = Transaction.previewTransactions
        let limit = 1
        
        // When
        let filtredTransaction = transactions.getRecentTransactions(limit: limit)
        
        // Then
        XCTAssertEqual(filtredTransaction[0].value, Transaction.previewTransactions[0].value)
        XCTAssertEqual(filtredTransaction[0].label, Transaction.previewTransactions[0].label)
        XCTAssertEqual(filtredTransaction.count, limit)
    }
    // MARK: - Double
    func test_Double_toEuroFormat() {
        // Given
        let double: Double = 1250.50
        
        //When
        let euro = double.toEuroFormat()
        
        // Then
        XCTAssertEqual(euro, "1 250,50€")
    }
    
    // MARK: - Decimal
    func test_Decimal_toEuroFormat() {
        // Given
        let decimal: Decimal = 1250.50
        
        //When
        let euro = decimal.toEuroFormat()
        
        // Then
        XCTAssertEqual(euro, "1 250,50€")
    }
    
    // MARK: - String
    func test_localized() {
        // Given
        let key = "hello_world"
        let expectedTranslation = NSLocalizedString(key, comment: key)
        
        // When
        let result = key.localized
        
        // Then
        XCTAssertEqual(result, expectedTranslation)
    }
    
    func test_toDecimal_withValidString() {
        // Given
        let validDecimalString = "123.45"
        let expectedDecimal = Decimal(string: validDecimalString)
        
        // When
        let result = validDecimalString.toDecimal()
        
        // Then
        XCTAssertEqual(result, expectedDecimal)
    }
    
    func test_toDecimal_withInvalidString() {
        // Given
        let invalidDecimalString = "invalid"
        
        // When
        let result = invalidDecimalString.toDecimal()
        
        // Then
        XCTAssertNil(result)
    }
    
    func test_isValidEmail_withValidEmail() {
        // Given
        let validEmail = "test@example.com"
        
        // When
        let result = validEmail.isValidEmail()
        
        // Then
        XCTAssertTrue(result)
    }
    
    func test_isValidEmail_withInvalidEmail() {
        // Given
        let invalidEmail = "invalid-email"
        
        // When
        let result = invalidEmail.isValidEmail()
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValidPhoneNumber_withValidPlus33PhoneNumber() {
        // Given
        let validPhoneNumber = "+33123456789"
        
        // When
        let result = validPhoneNumber.isValidPhoneNumber()
        
        // Then
        XCTAssertTrue(result)
    }
    
    func test_isValidPhoneNumber_withValidZeroPhoneNumber() {
        // Given
        let validPhoneNumber = "0123456789"
        
        // When
        let result = validPhoneNumber.isValidPhoneNumber()
        
        // Then
        XCTAssertTrue(result)
    }
    
    func test_isValidPhoneNumber_withInvalidPhoneNumber() {
        // Given
        let invalidPhoneNumber = "12345"
        
        // When
        let result = invalidPhoneNumber.isValidPhoneNumber()
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_isValidPhoneNumber_withPhoneNumberContainingSpaces() {
        // Given
        let validPhoneNumberWithSpaces = "+33 1 23 45 67 89"
        
        // When
        let result = validPhoneNumberWithSpaces.isValidPhoneNumber()
        
        // Then
        XCTAssertTrue(result)
    }
}


