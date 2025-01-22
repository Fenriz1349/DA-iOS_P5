//
//  AuraTestAccountViewModel.swift
//  AuraTests
//
//  Created by Julien Cotte on 21/01/2025.
//

import Foundation

import XCTest
@testable import Aura

class AuraTestsAccountViewModel: XCTestCase {

    // MARK: - AccountViewModel Tests
    
    func testGetUserResponse_invalidAccount() async {
        // Given
        let mockRepository = MockAccountRepository()
        mockRepository.accountResponse = nil
        let appViewModel = await AppViewModel()
        let viewModel = await AccountViewModel(repository: mockRepository, appViewModel: appViewModel)
        
        // When
        let response = await viewModel.getUserResponse()
        
        // Then
        await MainActor.run {
            XCTAssertNil(response)
            XCTAssertTrue(viewModel.accountIsError)
            XCTAssertEqual(viewModel.accountErrorMessage, "fetchAccount".localized)
        }
    }

    func testGetUserResponse_validAccount() async {
        // Given
        let mockRepository = MockAccountRepository()
        mockRepository.accountResponse = User.defaultAccountResponse
        let appViewModel = await AppViewModel()
        let viewModel = await AccountViewModel(repository: mockRepository, appViewModel: appViewModel)
        
        // When
        let response = await viewModel.getUserResponse()
        
        // Then
        await MainActor.run {
            XCTAssertNotNil(response)
            XCTAssertTrue(viewModel.accountIsError)
            XCTAssertNil(viewModel.accountErrorMessage)
        }
    }

    func testUpdateAppUser_invalidAccount() async {
        // Given
        let mockRepository = MockAccountRepository()
        mockRepository.accountResponse = nil
        let appViewModel = await AppViewModel()
        let viewModel = await AccountViewModel(repository: mockRepository, appViewModel: appViewModel)
        
        // When
        await viewModel.updateAppUser()
        
        // Then
        await MainActor.run {
            XCTAssertTrue(viewModel.accountIsError)
            XCTAssertEqual(viewModel.accountErrorMessage, "fetchAccount".localized)
        }
    }

    func testUpdateAppUser_validAccount() async {
        // Given
        let mockRepository = MockAccountRepository()
        let validAccountResponse = User.defaultAccountResponse
        mockRepository.accountResponse = validAccountResponse
        let appViewModel = await AppViewModel()
        let viewModel = await AccountViewModel(repository: mockRepository, appViewModel: appViewModel)
        
        // When
        await viewModel.updateAppUser()
        let sucessMessage = await String(format: "loginSucess".localized, appViewModel.userApp.username)
        // Then
        await MainActor.run {
            XCTAssertEqual(viewModel.accountErrorMessage, sucessMessage)
            XCTAssertFalse(viewModel.accountIsError)
            XCTAssertEqual(appViewModel.userApp.currentBalance, validAccountResponse.currentBalance)
        }
    }
}

