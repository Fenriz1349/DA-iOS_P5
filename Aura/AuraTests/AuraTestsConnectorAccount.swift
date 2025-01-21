//
//  AuraTestsConnectorAccount.swift
//  AuraTests
//
//  Created by Julien Cotte on 20/12/2024.
//

import Foundation
import XCTest
@testable import Aura

class AuraTestsConnectorAccount: XCTestCase {
    
    func testPerformGetAccount_Failure_MissingToken() async throws {
        // Given
        let username = "test@test.com"
        let mockSession = MockURLSession.shared
        let mockKeychainService = MockKeychainService()
        mockKeychainService.mockToken = nil // Pas de token dans le Keychain
        
        let sut = ConnectorAccount(session: mockSession, keychainService: mockKeychainService)
        
        // When
        do {
            let _ = try await sut.performGetAccount(username: username)
        } catch let error as URLError {
            // Then
            XCTAssertEqual(error.code, .userAuthenticationRequired)
        }
    }
    
    func testPerformGetAccount_Failure_HTTPStatusCode() async throws {
        // Given
        let username = "test@test.com"
        let mockSession = MockURLSession.shared
        let mockKeychainService = MockKeychainService()
        mockKeychainService.mockToken = UUID(uuidString: "12345-uuid")
        
        let sut = ConnectorAccount(session: mockSession, keychainService: mockKeychainService)
        let url = URL(string: "https://example.com/account")!
        
        // Simuler une réponse HTTP avec un code d'erreur (500)
        let mockData = Data("mock account data".utf8)
        let mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.mockResponseData = mockData
        MockURLProtocol.mockResponse = mockResponse
        MockURLProtocol.mockError = nil
        
        // When
        do {
            let _ = try await sut.performGetAccount(username: username)
            XCTFail("Expected bad server response error but got success response")
        } catch let error as URLError {
            // Then
            XCTAssertEqual(error.code, .userAuthenticationRequired)
        }
    }
    
    func testPerformGetAccount_Failure_InvalidResponse() async throws {
        // Given
        let username = "test@test.com"
        let mockSession = MockURLSession.shared
        let mockKeychainService = MockKeychainService()
        mockKeychainService.mockToken = UUID(uuidString: "12345-uuid")
        
        let sut = ConnectorAccount(session: mockSession, keychainService: mockKeychainService)
        let url = URL(string: "https://example.com/account")!
        
        // Simuler une réponse HTTP avec un code 404
        let mockData = Data("mock account data".utf8)
        let mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.mockResponseData = mockData
        MockURLProtocol.mockResponse = mockResponse
        MockURLProtocol.mockError = nil
        
        // When
        do {
            let _ = try await sut.performGetAccount(username: username)
        } catch let error as URLError {
            // Then
            XCTAssertEqual(error.code, .userAuthenticationRequired)
        }
    }
}
