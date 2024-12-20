//
//  AuraTestsKeychainService.swift
//  AuraTests
//
//  Created by Julien Cotte on 20/12/2024.
//

import Foundation

import Foundation
import XCTest
@testable import Aura

class AuraTestsKeychainService: XCTestCase {
    func testSave_Sucess() {
        // Given
        let keychain = KeychainService()
        let key = "validKey"
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        
        // When
        let result = keychain.save(key: key, data: data)
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testSave_invalidToken_Fail() {
        // Given
        let keychain = KeychainService()
        let key = "invalidKey"
        let token = "invalidToken".utf8
        let data = Data(token)
        
        // When
        let result = keychain.save(key: key, data: data)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testSave_emptyKey_Fail() {
        // Given
        let keychain = KeychainService()
        let key = ""
        let token = "invalidToken".utf8
        let data = Data(token)
        
        // When
        let result = keychain.save(key: key, data: data)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testLoad_Sucess() {
        // Given
        let keychain = KeychainService()
        let key = "validKey"
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        let _ = keychain.save(key: key, data: data)
        
        // When
        let dataReturned = keychain.load(key: key)
        
        // Then
        XCTAssertEqual(dataReturned, data)
    }
    
    func testLoad_KeyDoesNotExist() {
        // Given
        let keychain = KeychainService()
        let key = "nonExistentKey"
        
        // When
        let dataReturned = keychain.load(key: key)
        
        // Then
        XCTAssertNil(dataReturned)
    }
    
    func testDelete() {
        // Given
        let keychain = KeychainService()
        let key = "validKey"
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        let _ = keychain.save(key: key, data: data)
        
        // When
        keychain.delete(key: key)
        
        // Then
        XCTAssertNil(keychain.load(key: key))
    }
}
