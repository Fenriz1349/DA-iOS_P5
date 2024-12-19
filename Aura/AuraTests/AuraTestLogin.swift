//
//  AuraTestLogin.swift
//  AuraTests
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation
import XCTest
@testable import Aura

class AuraTestsLogin: XCTestCase {
    
    func testLogin_tryGets_returnFalse() async {
        // Given
        let mockClient = MockHTTPClient()
        mockClient.mockData = Data("Wrong Data".utf8)
        let repository = AuthenticationRepository(client: mockClient)
        let sut = AuthenticationViewModel(onLoginSucceed: {}, repository: repository)
        
        // When
        await sut.login(usermail: "", password: "")
        // Then
        XCTAssertEqual(sut.errorMessage!, "Erreur de connexion au serveur")
        XCTAssertNil(sut.user)
    }

    func testLogin_emailFormatError() async {
        // Given
        let sut = AuthenticationViewModel(onLoginSucceed: {})
        
        // When
        await sut.login(usermail: "", password: "validPassword")
        
        // Then
        XCTAssertEqual(sut.errorMessage!, "Le format de l'email n'est pas valide")
        XCTAssertNil(sut.user)
    }
    
//    func testLogin_tokenError() async {
//        // Given
//        let sut = AuthenticationViewModel({})
//        
//        // When
//        await sut.login(usermail: "test@test.com", password: "")
//        
//        // Then
//        XCTAssertEqual(sut.errorMessage!, "Mauvaise adresse mail / mot de passe")
//        XCTAssertNil(sut.user)
//    }
    
}
