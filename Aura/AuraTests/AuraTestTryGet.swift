//
//  AuraTestTryGet.swift
//  AuraTests
//
//  Created by Julien Cotte on 06/12/2024.
//

import XCTest
@testable import Aura

class AuraTestsTryGet: XCTestCase {
    
//    func testTryGetURL_Sucess_WrongString() async {
//        // Given
//        let mock = tryMockIncorrectStringData()
//        let sut = AuthenticationRepository(executeDataRequest: mock)
//        
//        do {
//            let result = try await sut.tryGet()
//            XCTAssertFalse(result)
//        } catch {
//            XCTFail("Aucune erreur ne devrait être levée : \(error)")
//        }
//    }
    
    func testTryGet_Success() async {
        let url = URL(string: "https://example.com")!
        let mockData = Data("It works!".utf8)
        let mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.mockResponseData = mockData
        MockURLProtocol.mockResponse = mockResponse
        MockURLProtocol.mockError = nil
        Connector.session = MockURLSession.shared
        
        let result = await AuthenticationRepository().tryGet(url: url)
        XCTAssertTrue(result)
    }
    
    func testTryGet_NetworkError() async {
        let url = URL(string: "https://example.com")!
        
        MockURLProtocol.mockError = URLError(.notConnectedToInternet)
        Connector.session = MockURLSession.shared
        
        let result = await AuthenticationRepository().tryGet(url: url)
        XCTAssertFalse(result)
    }
    
    func testTryGet_InvalidData() async {
        let url = URL(string: "https://example.com")!
        let mockData = Data([0xFF, 0xD8]) // Données non décodables en UTF-8
        let mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.mockResponseData = mockData
        MockURLProtocol.mockResponse = mockResponse
        Connector.session = MockURLSession.shared
        
        let result = await AuthenticationRepository().tryGet(url: url)
        XCTAssertFalse(result)
    }
    
    func testTryGet_IncorrectContent() async {
        let url = URL(string: "https://example.com")!
        let mockData = Data("Wrong content".utf8)
        let mockResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        MockURLProtocol.mockResponseData = mockData
        MockURLProtocol.mockResponse = mockResponse
        Connector.session = MockURLSession.shared
        
        let result = await AuthenticationRepository().tryGet(url: url)
        XCTAssertFalse(result)
    }
    
}

