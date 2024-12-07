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
    func testCreateURLRequest() throws {
        // Given
        let url = URL(string: "https://example.com")!
        let method = HTTPMethod.GET
        
        // When
        let request = try Connector.createURLRequest(from: url, with: method)
        
        // Then
        XCTAssertEqual(request.url, url)
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testExecuteDataRequest_Success() async throws {
            let url = URL(string: "https://example.com")!
            let method = HTTPMethod.GET
            let request = try Connector.createURLRequest(from: url, with: method)
            
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
            Connector.session = MockURLSession.shared // Injecter la session mockée
            
            let (data, response) = try await Connector.executeDataRequest(request)
            
            XCTAssertEqual(data, mockData)
            XCTAssertEqual(response.statusCode, 200)
        }
    
    func testExecuteDataRequest_HTTPURLResponseError() async throws {
        let url = URL(string: "https://example.com")!
        let method = HTTPMethod.GET
        let request = try Connector.createURLRequest(from: url, with: method)
        
        // Simuler une URLResponse au lieu de HTTPURLResponse
        MockURLProtocol.mockResponse = URLResponse(
                url: url,
                mimeType: "text/plain",
                expectedContentLength: 100,
                textEncodingName: nil
            )
        Connector.session = MockURLSession.shared
        
        do {
            let _ = try await Connector.executeDataRequest(request)
        } catch let error as URLError {
            XCTAssertEqual(error.code, URLError.Code.badServerResponse)
        }
    }
    
    func testPerformRequest_Success() async throws {
            let url = URL(string: "https://example.com")!
        let method = HTTPMethod.GET
            
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
            Connector.session = MockURLSession.shared
            
            let data = try await Connector.performRequest(from: url, with: method)
            
        XCTAssertEqual(data, mockData)
        }
   
    func testPerformRequest_Failure_HTTPStatusCode() async throws {
           let url = URL(string: "https://example.com")!
           let method = HTTPMethod.GET
           
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
           Connector.session = MockURLSession.shared
           
           do {
               let _ = try await Connector.performRequest(from: url, with: method)
           } catch let error as URLError {
               XCTAssertEqual(error.code, URLError.Code.cannotConnectToHost)
           }
        }
}
