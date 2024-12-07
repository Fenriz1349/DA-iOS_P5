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
    
    func testTryGetURL_Sucess() async {
        // Given
        let mock = tryMockSuccessWithExpectedData()
        let sut = AuthenticationRepository(executeDataRequest: mock)
        
        do {
            let result = try await sut.tryGet()
            XCTAssertTrue(result)
        } catch {
        }
    }
}

extension AuraTestsTryGet {
    
    // Mock pour une réponse correcte mais avec un contenu qui n'est pas "It Works!"
    func tryMockIncorrectStringData() -> (URLRequest) async throws -> (Data, URLResponse) {
        return { _ in
            let response = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            // Contenu différent de "It Works!"
            return (Data("Wrong Message".utf8), response)
        }
    }
    
    
    // Mock pour une bonne connexion avec une réponse attendue
    func tryMockSuccessWithExpectedData() -> (URLRequest) async throws -> (Data, URLResponse) {
        return { _ in
            let response = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            // Réponse correcte avec "It Works!"
            return (Data("It works!".utf8), response)
        }
    }
}
