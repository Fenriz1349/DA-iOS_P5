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
    

//    func testLogin_emailFormatError() async {
//        // Given
//        let sut = AuthenticationViewModel({})
//        
//        // When
//        await sut.login(usermail: "", password: "validPassword")
//        
//        // Then
//        XCTAssertEqual(sut.errorMessage!, "Le format de l'email n'est pas valide")
//        XCTAssertNil(sut.user)
//    }
    
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
    
    func testLogin_Sucess() async {
        // Given
        let appViewModel = AppViewModel()
        let sut = appViewModel.authenticationViewModel
        
        // When
        await sut.login(usermail: "test@test.app", password: "ValidPassword")
//        let user = sut.user!
        // Then
//        XCTAssertEqual(user.userEmail.emailAdress, "test@test.app")
//        XCTAssertEqual(user.userPassword, "ValidPassword")
//        XCTAssertTrue(user.transactions.isEmpty)
//        XCTAssertTrue(user.token is UUID)
//        XCTAssertNil(sut.errorMessage)
//        XCTAssertTrue(appViewModel.isLogged)
    }
}
