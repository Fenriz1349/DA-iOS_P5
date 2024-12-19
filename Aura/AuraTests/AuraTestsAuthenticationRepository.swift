//
//  AuraTestTryGet.swift
//  AuraTests
//
//  Created by Julien Cotte on 06/12/2024.
//

import XCTest
@testable import Aura

class AuraTestsAuthenticationRepository: XCTestCase {
    
    func testTryGet_Success() async {
        // Given
        // Création d'un client et simulation de sa réponse
        let mockClient = MockHTTPClient()
        mockClient.mockData = Data("It works!".utf8)
        let url = URL(string: "https://example.com")!
        // Injection du client dans le repository
        let sut = AuthenticationRepository(client: mockClient)
        
        // When
        let result = await sut.tryGet(url: url)
        // Then
        XCTAssertTrue(result)
    }
    
    func testTryGetURL_Sucess_WrongString() async {
        // Given
        let mockClient = MockHTTPClient()
        mockClient.mockData = Data("Wrong Data".utf8)
        let url = URL(string: "https://example.com")!
        let sut = AuthenticationRepository(client: mockClient)
        
        // When
        let result = await sut.tryGet(url: url)
        // Then
        XCTAssertFalse(result)
    }
    
    func testTryGet_NetworkError() async {
        // Given
        let mockClient = MockHTTPClient()
        let url = URL(string: "https://example.com")!
        let sut = AuthenticationRepository(client: mockClient)
        
        // When
        mockClient.mockError = URLError(.notConnectedToInternet)
        
        let result = await sut.tryGet(url: url)
        XCTAssertFalse(result)
    }
    
    func testTryGet_InvalidData() async {
        // Given
        let mockClient = MockHTTPClient()
        let url = URL(string: "https://example.com")!
        let sut = AuthenticationRepository(client: mockClient)
        
        // When
        mockClient.mockData = Data([0xFF, 0xD8]) // Données non décodables en UTF-8
        
        // Then
        let result = await sut.tryGet(url: url)
        XCTAssertFalse(result)
    }
    
    func testGetTokenFrom_Success_ReturnsToken() async {
        // Given
        let mockClient = MockHTTPClient()
        let email = Email(local: Local(name: "test"), domain: Domain(name: "test", domExtension: "com"))
        let password = "password"
        let validUUIDString = "123E4567-E89B-12D3-A456-426614174000"
        let json = """
            {
                "token": "\(validUUIDString)"
            }
            """
        mockClient.mockData = Data(json.utf8)
        let repository = AuthenticationRepository(client: mockClient)
        
        
        // When
        let result = await repository.getTokenFrom(username: email, password: password)
        
        // Then
        XCTAssertEqual(result?.uuidString, validUUIDString)
    }
    
    func testGetTokenFrom_JSONWithoutTokenKey_ReturnsNil() async {
        // Given
        let email = Email(local: Local(name: "test"), domain: Domain(name: "test", domExtension: "com"))
        let password = "password"
        let mockClient = MockHTTPClient()
        let json = """
            {
                "key": "value"
            }
            """
        mockClient.mockData = Data(json.utf8)
        let repository = AuthenticationRepository(client: mockClient)
        
        // When
        let result = await repository.getTokenFrom(username: email, password: password)
        
        // Then
        XCTAssertNil(result)
    }
    
    func testGetTokenFrom_RequestFails_ReturnsNil() async {
          // Given
        let email = Email(local: Local(name: "test"), domain: Domain(name: "test", domExtension: "com"))
        let password = "password"
          let mockClient = MockHTTPClient()
          mockClient.mockError = URLError(.notConnectedToInternet)
          let repository = AuthenticationRepository(client: mockClient)
          
          // When
        let result = await repository.getTokenFrom(username: email, password: password)
          
          // Then
          XCTAssertNil(result)
      }
}

