//
//  AuraTestsAppViewModel.swift
//  AuraTests
//
//  Created by Julien Cotte on 19/12/2024.
//

import Foundation
import XCTest
@testable import Aura

class AuraTestsAppViewModel: XCTestCase {
    func testInit() async {
        let context = AppViewModel()
        XCTAssertFalse(context.isLogged)
        XCTAssertNil(KeychainService.load(key: "authToken"))
        let authenticationViewModel = context.authenticationViewModel
        await authenticationViewModel.login(usermail: "test@aura.app", password: "test123")
        XCTAssertTrue(context.isLogged)
        XCTAssertNotNil(KeychainService.load(key: "authToken"))
    }
}
