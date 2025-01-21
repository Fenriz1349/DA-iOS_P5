//
//  AuraTestsConnectorAuthentication.swift
//  AuraTests
//
//  Created by Julien Cotte on 20/12/2024.
//

import Foundation
import XCTest
@testable import Aura

class AuraTestsConnectorAuthentication: XCTestCase {
    func testPerformAuthRequest_Success() async throws {
        // Given
        let username = "test@test.com"
        let password = "password"
        let mockSession = MockURLSession.shared
        let sut = ConnectorAuthentication( session: mockSession)
        let url = URL(string: "https://example.com")!
        
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
        let data = try await sut.performAuthRequest(username: username, password: password)
        
        XCTAssertEqual(data, mockData)
    }
    
    func testPerformAuthequest_Failure_HTTPStatusCode() async throws {
        // Given
        let username = "test@test.com"
        let password = "password"
        let mockSession = MockURLSession.shared
        let sut = ConnectorAuthentication( session: mockSession)
        let url = URL(string: "https://example.com")!
        
        // When
        // Simuler une réponse HTTP avec un code d'erreur (500)
        let mockData = Data("mock data".utf8)
        let mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.mockResponseData = mockData
        MockURLProtocol.mockResponse = mockResponse
        
        // Then
        do {
            let _ = try await sut.performAuthRequest(username: username, password: password)
        } catch let error as URLError {
            XCTAssertEqual(error.code, URLError.Code.badServerResponse)
        }
    }
}
