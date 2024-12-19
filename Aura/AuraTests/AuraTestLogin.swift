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
    
    func testLogin_Success() async {
        // Given
        let mockRepository = MockAuthenticationRepository()
        mockRepository.tryGetResult = true
        mockRepository.getTokenResult = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")
                
        var isSucess = false
        let sut = AuthenticationViewModel(onLoginSucceed: {isSucess = true}, repository: mockRepository)
        
        // When
        await sut.login(usermail: "test@aura.app", password: "test123")
        
        // Then
        XCTAssertNil(sut.errorMessage)
        XCTAssertEqual(sut.user?.userEmail.emailAdress, "test@aura.app")
        XCTAssertTrue(isSucess)
    }
    
    func testLogin_tryGets_returnFalse() async {
        // Given
        let mockRepository = MockAuthenticationRepository()
        mockRepository.tryGetResult = false
        let sut = AuthenticationViewModel(onLoginSucceed: {}, repository: mockRepository)
        
        // When
        await sut.login(usermail: "", password: "")
        // Then
        XCTAssertEqual(sut.errorMessage!, "Erreur de connexion au serveur")
        XCTAssertNil(sut.user)
    }

    func testLogin_emailFormatError() async {
        // Given
        let mockRepository = MockAuthenticationRepository()
        mockRepository.tryGetResult = true
        let sut = AuthenticationViewModel(onLoginSucceed: {}, repository: mockRepository)
        
        // When
        await sut.login(usermail: "", password: "validPassword")
        
        // Then
        XCTAssertEqual(sut.errorMessage!, "Le format de l'email n'est pas valide")
        XCTAssertNil(sut.user)
    }
    
    func testLogin_tokenError() async {
        // Given
        let mockRepository = MockAuthenticationRepository()
        mockRepository.tryGetResult = true
        mockRepository.getTokenResult = nil
        let sut = AuthenticationViewModel(onLoginSucceed: {}, repository: mockRepository)
        
        // When
        await sut.login(usermail: "test@test.com", password: "wrongPassword")
        
        // Then
        XCTAssertEqual(sut.errorMessage, "Mauvaise adresse mail / mot de passe")
        XCTAssertNil(sut.user)
    }
}
