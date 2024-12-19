//
//  AuraTestGetToken.swift
//  AuraTests
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation

import XCTest
@testable import Aura

class AuraTestsGetToken: XCTestCase {
    
//    func testGetTokenFrom_MalformedJSON() async {
//        // Given
//        let mockmail = Email.from("test@example.com")!
//        let mock = tryMockInvalidJSONResponse()
//        let sut = AuthenticationRepository(executeDataRequest: mock)
//        
//        // Then
//        do {
//            _ = try await sut.getTokenFrom(username: mockmail, password: "password")
//        } catch let error as URLError {
//            XCTAssertEqual(error.code, .cannotDecodeContentData)
//        } catch { }
//    }
    
//    func testGetTokenFrom_CannotParse() async {
//        // Given
//        let mockmail = Email.from("test@example.com")!
//        let mock = tryMockInvalidToken()
//        let sut = AuthenticationRepository(executeDataRequest: mock)
//        
//        // Then
//        do {
//            _ = try await sut.getTokenFrom(username: mockmail, password: "password")
//        } catch let error as URLError {
//            print(error)
//            XCTAssertEqual(error.code, .cannotParseResponse)
//        } catch { }
//    }
    
//    func testGetTokenFrom_ValidTokenResponse() async {
//        // Given
//        let mockmail = Email.from("test@example.com")!
//        let mock = tryMockValidTokenResponse()
//        let sut = AuthenticationRepository(executeDataRequest: mock)
//        
//        // When
//        do {
//            let token = try await sut.getTokenFrom(username: mockmail, password: "password")
//            XCTAssertNotNil(token)
//            XCTAssertTrue(token is UUID)
//        } catch {
//        }
//    }
}

extension AuraTestsGetToken {
    // Mock pour simuler la reponse qui n'est pas un JSON
    func tryMockInvalidJSONResponse() -> (URLRequest) async throws -> (Data, URLResponse) {
        return { _ in
            let response = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let invalidJSON = "Invalid JSON Data".data(using: .utf8)!
            return (invalidJSON, response)
        }
    }
    
    // Mock pour simuler la reponse d'un JSON non valide
    func tryMockInvalidToken() -> (URLRequest) async throws -> (Data, URLResponse) {
        return { _ in
            let response = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = try! JSONSerialization.data(withJSONObject: ["otherKey": "value"], options: [])
            return (data, response)
        }
    }
    
    // Mock pour une réponse correcte avec un token valide
    func tryMockValidTokenResponse() -> (URLRequest) async throws -> (Data, URLResponse) {
        return { _ in
            let response = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = try! JSONSerialization.data(withJSONObject: ["token": UUID().uuidString], options: [])
            return (data, response)
        }
    }
}
