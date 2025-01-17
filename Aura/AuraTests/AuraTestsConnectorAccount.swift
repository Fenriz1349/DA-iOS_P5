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
//    func testPerformGetAccount_Sucess() async {
//        // Given
//        let username = "test@test.com"
//        let mockToken = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
//        let mockData = Data("account details".utf8)
//        
//        // Simule un token valide dans le tokenKeychain
//        let mockKeychain = MockKeychainService()
//        mockKeychain.mockToken = mockToken
//
//        // When
//        // Simuler une réponse HTTP valide
//        let url = AppConfig().getAccountURL
//        let mockResponse = HTTPURLResponse(
//            url: url,
//            statusCode: 200,
//            httpVersion: nil,
//            headerFields: nil
//        )!
//        
//        MockURLProtocol.mockResponseData = mockData
//        MockURLProtocol.mockResponse = mockResponse
//        MockURLProtocol.mockError = nil
//        let mockSession = MockURLSession.shared
//        let sut = ConnectorAccount( session: mockSession, keychainService: mockKeychain)
//        
//        // Then
//        do {
//            let data = try await sut.performGetAccount(username: username)
//            XCTAssertEqual(data, mockData)
//        } catch {
//            XCTFail("La requête a échoué avec une erreur: \(error)")
//        }
//    }
    
    func testPerformGetAccount_Fail_wrongUsername() async {
        // Given
        let invalidKey = "invalidKey"
        let mockSession = MockURLSession.shared
        let sut = ConnectorAccount( session: mockSession)
        let url = URL(string: "https://example.com")!
        
        // Simule un token valide dans le tokenKeychain
        let keychain = MockKeychainService()
        keychain.mockToken = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")
        
        // When
        // Simuler une réponse HTTP valide
        let mockData = Data("mock data".utf8)
        let mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.mockResponseData = mockData
        MockURLProtocol.mockResponse = mockResponse
        MockURLProtocol.mockError = nil
        
        // Then
        do {
            let _ = try await sut.performGetAccount(username: invalidKey)
        } catch let error as URLError {
            XCTAssertEqual(error.code, URLError.Code.userAuthenticationRequired)
        } catch {
            
        }
    }

}
