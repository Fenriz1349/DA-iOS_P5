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
    func testLogin_invalidEmailFormat() async {
        // Given
        let mockRepository = MockAuthenticationRepository()
        let viewModel = await AuthenticationViewModel(
            onLoginSucceed: { _ in },
            appViewModel: AppViewModel(),
            repository: mockRepository
        )
        
        // When
        await viewModel.login(username: "invalid-email", password: "password123")
        
        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.autenticationIsError)
            XCTAssertEqual(viewModel.authenticationErrorMessage, "invalidMailFormat".localized)
        }
    }

    func testLogin_tryGet_returnFalse() async {
        // Given
        let mockRepository = MockAuthenticationRepository()
        mockRepository.tryGetResult = false
        let viewModel = await AuthenticationViewModel(
            onLoginSucceed: { _ in },
            appViewModel: AppViewModel(),
            repository: mockRepository
        )
        
        // When
        await viewModel.login(username: "invalid-email", password: "password123")
        
        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.autenticationIsError)
            XCTAssertEqual(viewModel.authenticationErrorMessage, "connexionFailed".localized)
        }
    }
    
    func testLogin_keychainSaveFails() async {
        // Given
        let mockRepository = MockAuthenticationRepository()
        mockRepository.getTokenResult = UUID() // Simuler une authentification réussie
        
        let mockKeychain = MockKeychainService()
        mockKeychain.shouldSaveSucceed = false // Simuler un échec d'enregistrement dans le Keychain
        
        let appViewModel = await AppViewModel()
        let viewModel = await AuthenticationViewModel(
            onLoginSucceed: { _ in },
            appViewModel: appViewModel,
            repository: mockRepository,
            keychain: mockKeychain
        )
        
        // When
        await viewModel.login(username: "valid.email@example.com", password: "correctPassword123")
        
        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.autenticationIsError)
            XCTAssertEqual(viewModel.authenticationErrorMessage, "tokenFail".localized)
        }
    }

    
    func testLogin_validEmailFormat_butInvalidCredentials() async {
        // Given
        let mockRepository = MockAuthenticationRepository()
        mockRepository.getTokenResult = nil // Simuler un échec d'authentification
        let viewModel = await AuthenticationViewModel(
            onLoginSucceed: { _ in },
            appViewModel: AppViewModel(),
            repository: mockRepository
        )
        
        // When
        await viewModel.login(username: "valid.email@example.com", password: "wrongPassword123")
        
        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.autenticationIsError)
            XCTAssertEqual(viewModel.authenticationErrorMessage, "wrongLogin".localized)
        }
    }

    func testLogin_validCredentials() async {
        // Given
        let mockRepository = MockAuthenticationRepository()
        mockRepository.getTokenResult = UUID() // Simuler une authentification réussie
        let mockKeychain = MockKeychainService()
        let appViewModel = await AppViewModel()
        let viewModel = await AuthenticationViewModel(
            onLoginSucceed: { _ in },
            appViewModel: appViewModel,
            repository: mockRepository,
            keychain: mockKeychain
        )
        
        // When
        await viewModel.login(username: "valid.email@example.com", password: "correctPassword123")
        
        // Then
        await MainActor.run {
            XCTAssertNil(viewModel.authenticationErrorMessage)
            XCTAssertEqual(appViewModel.userApp.username, "valid.email@example.com")
        }
    }
}
