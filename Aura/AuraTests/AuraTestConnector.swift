//
//  AuraTestConnector.swift
//  AuraTests
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation
import XCTest
@testable import Aura

class AuraTestsConnector: XCTestCase {
    func testAppConfig() {
        let config = AppConfig()
        XCTAssertEqual(config.authURLString, "http://127.0.0.1:8080/auth")
        XCTAssertEqual(config.authURL, URL(string: "http://127.0.0.1:8080/auth")!)
        XCTAssertEqual(config.getAccountURL(), URL(string: "http://127.0.0.1:8080/account")!)
    }
    
    func testCreateURLRequest() throws {
        // Given
        let sut = Connector()
        let url = URL(string: "https://example.com")!
        let method = HTTPMethod.GET
        
        // When
        let request = try sut.createURLRequest(from: url, with: method)
        
        // Then
        XCTAssertEqual(request.url, url)
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testExecuteDataRequest_Success() async throws {
        // Given
        let mockSession = MockURLSession.shared
        let sut = Connector( session: mockSession)
        let url = URL(string: "https://example.com")!
        let method = HTTPMethod.GET
        let request = try sut.createURLRequest(from: url, with: method)
        
        // When
        // Simuler une réponse HTTP valide
        let mockData = Data("mock data".utf8)
        let mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        // Configurer le MockURLProtocol pour renvoyer les données simulées
        MockURLProtocol.mockResponseData = mockData
        MockURLProtocol.mockResponse = mockResponse
        MockURLProtocol.mockError = nil
        
        let (data, response) = try await sut.executeDataRequest(request)
        
        // Then
        XCTAssertEqual(data, mockData)
        XCTAssertEqual(response.statusCode, 200)
    }
    
    func testExecuteDataRequest_HTTPURLResponseError() async throws {
        // Given
        let mockSession = MockURLSession.shared
        let sut = Connector( session: mockSession)
        let url = URL(string: "https://example.com")!
        let method = HTTPMethod.GET
        let request = try sut.createURLRequest(from: url, with: method)
        
        // When
        // Simuler une URLResponse au lieu de HTTPURLResponse
        MockURLProtocol.mockResponse = URLResponse(
                url: url,
                mimeType: "text/plain",
                expectedContentLength: 100,
                textEncodingName: nil
            )
        MockURLProtocol.mockResponseData = Data()
        
        // Then
        do {
            let _ = try await sut.executeDataRequest(request)
        } catch let error as URLError {
            XCTAssertEqual(error.code, URLError.Code.badServerResponse)
        }
    }
    
    func testPerformRequest_Success() async throws {
        // Given
        let mockSession = MockURLSession.shared
        let sut = Connector( session: mockSession)
        let url = URL(string: "https://example.com")!
        let method = HTTPMethod.GET
        
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
        let data = try await sut.performRequest(from: url, with: method)
        
        XCTAssertEqual(data, mockData)
    }
   
    func testPerformRequest_Failure_HTTPStatusCode() async throws {
        // Given
        let mockSession = MockURLSession.shared
        let sut = Connector( session: mockSession)
        let url = URL(string: "https://example.com")!
        let method = HTTPMethod.GET
        
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
            let _ = try await sut.performRequest(from: url, with: method)
        } catch let error as URLError {
            XCTAssertEqual(error.code, URLError.Code.badServerResponse)
        }
    }
}
