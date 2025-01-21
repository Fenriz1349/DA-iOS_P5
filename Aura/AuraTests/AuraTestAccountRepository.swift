//
//  AuraTestAccountRepository.swift
//  AuraTests
//
//  Created by Julien Cotte on 21/01/2025.
//

import Foundation

import XCTest
@testable import Aura

class AuraTestAccountRepository: XCTestCase {
    func testGetAccountResponse_Success() async throws {
            // Given
            let mockClient = MockHTTPClientAccount()
            let sut = AccountRepository(client: mockClient)
            let username = "test@test.com"
            
            // Simuler une réponse JSON valide
            let mockResponse = AccountResponse(currentBalance: 100.0, transactions: [])
            let mockData = try JSONEncoder().encode(mockResponse)
            mockClient.mockData = mockData
            mockClient.mockError = nil
            
            // When
            let response = await sut.getAccountResponse(from: username)
            
            // Then
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.currentBalance, mockResponse.currentBalance)
        XCTAssertEqual(response?.transactions.count, 0)
        }
    
    func testGetAccountResponse_Failure_InvalidData() async throws {
            // Given
            let mockClient = MockHTTPClientAccount()
            let sut = AccountRepository(client: mockClient)
            let username = "test@test.com"
            
            // Simuler une réponse JSON invalide
            let invalidData = Data("invalid json".utf8)
            mockClient.mockData = invalidData
            mockClient.mockError = nil
            
            // When
            let response = await sut.getAccountResponse(from: username)
            
            // Then
            XCTAssertNil(response)
        }
    
    func testGetAccountResponse_Failure_NetworkError() async throws {
            // Given
            let mockClient = MockHTTPClientAccount()
            let sut = AccountRepository(client: mockClient)
            let username = "test@test.com"
            
            // Simuler une erreur réseau
            let networkError = URLError(.notConnectedToInternet)
            mockClient.mockData = nil
            mockClient.mockError = networkError
            
            // When
            let response = await sut.getAccountResponse(from: username)
            
            // Then
            XCTAssertNil(response)
        }
}
