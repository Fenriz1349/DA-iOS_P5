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
        let testKey = "validKey"
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        
        // When
        let result = keychain.save(key: testKey, data: data)
        
        // Then
        XCTAssertTrue(result)
        
        // Clean up
        keychain.delete(key: testKey)
    }
    
    func testSave_fail_emptyKey() {
        // Given
        let keychain = KeychainService()
        let emptyKey = ""
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        
        // When
        let result = keychain.save(key: emptyKey, data: data)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testSave_invalidToken_Fail() {
        // Given
        let keychain = KeychainService()
        let testKey = "validKey"
        let token = "invalidToken".utf8
        let data = Data(token)
        
        // When
        let result = keychain.save(key: testKey, data: data)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testLoad_Sucess() {
        // Given
        let keychain = KeychainService()
        let testKey = "testKey"
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        let _ = keychain.save(key: testKey,data: data)
        keychain.delete(key: "authKey")
        
        // When
        let dataReturned = keychain.load(key: testKey)
        
        // Then
        XCTAssertEqual(dataReturned, data)
        
        // Clean up
        keychain.delete(key: testKey)
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
        let key = "authKey"
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        let _ = keychain.save(key: key,data: data)
        
        // When
        keychain.delete(key: key)
        
        // Then
        XCTAssertNil(keychain.load(key: key))
    }
    
    func testGetToken_withValidData() {
        // Given
        let keychainService = KeychainService()
        let testKey = "validKey"
        let validUUID = UUID()
        let tokenData = validUUID.uuidString.data(using: .utf8)!
        
        // When
        let save = keychainService.save(key:testKey ,data: tokenData)
        let loadedToken = keychainService.getToken(key: testKey)!
        
        // Then
        XCTAssertTrue(save)
        XCTAssertEqual(loadedToken, validUUID)
        
        // Clean up
        keychainService.delete(key: "authKey")
    }
}
