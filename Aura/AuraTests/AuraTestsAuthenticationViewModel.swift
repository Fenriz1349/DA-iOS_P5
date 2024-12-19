//
//  AuraTestsAuthenticationViewModel.swift
//  AuraTests
//
//  Created by Julien Cotte on 06/12/2024.
//

import XCTest
@testable import Aura

class AuraTestsAuthenticationViewModel : XCTestCase {
    // MARK: - AuthentificationViewModel Tests
    @MainActor
    func testSetErrorMessage() {
        // Given
        let sut = AppViewModel().authenticationViewModel
        
        // When
        sut.setErrorMessage("erreur")
        
        // Then
        XCTAssertEqual(sut.errorMessage, "erreur")
    }
    
    @MainActor
    func testHideErrorMessage() {
        // Given
        let sut = AppViewModel().authenticationViewModel
        
        // When
        sut.hideErrorMessage()
        
        // Then
        XCTAssertNil(sut.errorMessage)
    }
}
