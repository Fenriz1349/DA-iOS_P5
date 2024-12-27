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
    func testSave_Sucess_defaultKey() {
        // Given
        let keychain = KeychainService()
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        
        // When
        let result = keychain.save(data: data)
        
        // Then
        XCTAssertTrue(result)
        
        // Clean up
        keychain.delete(key: "authKey")
        
    }
    
    func testSave_Sucess_otherKey() {
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
        let token = "invalidToken".utf8
        let data = Data(token)
        
        // When
        let result = keychain.save(data: data)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testLoad_Sucess_defaultKey() {
        // Given
        let keychain = KeychainService()
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        let _ = keychain.save(data: data)
        
        // When
        let dataReturned = keychain.load()
        
        // Then
        XCTAssertEqual(dataReturned, data)
    }
    
    func testLoad_Sucess_otherKey() {
        // Given
        let keychain = KeychainService()
        let testKey = "testKey"
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        let _ = keychain.save(key: testKey,data: data)
        keychain.delete(key: "authKey")
        
        // When
        let dataReturned = keychain.load(key: testKey)
        let dataDefault = keychain.load()
        
        // Then
        XCTAssertNil(dataDefault)
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
        let key = "authKey"
        let token = UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!
        let data = Data(token.uuidString.utf8)
        let _ = keychain.save(data: data)
        
        // When
        keychain.delete(key: key)
        
        // Then
        XCTAssertNil(keychain.load(key: key))
    }
    
    func testGetToken_Sucess_defaultKey() {
        // Given
        let keychain = MockKeychainService()
        let validUUID = UUID()
        let data = Data(validUUID.uuidString.utf8)
        
        // When
        let save = keychain.save(data: data)
        keychain.mockToken = validUUID
        let loadedToken = keychain.getToken(key: "authKey")!
        
        // Then
        XCTAssertTrue(save)
        XCTAssertEqual(loadedToken, validUUID)
    }
    
    func testGetToken_WrongKey() {
        // Given
        let keychain = MockKeychainService()
        let wrongKey = "wrongKey"
        let validUUID = UUID()
        let data = Data(validUUID.uuidString.utf8)
        
        // When
        let save = keychain.save(data: data)
        keychain.mockToken = validUUID
        let loadedToken = keychain.getToken(key: wrongKey)!
        
        // Then
        XCTAssertTrue(save)
        XCTAssertEqual(loadedToken, validUUID)
    }
    
    func testGetToken_realService_withValidData() {
        // Given
        let keychainService = KeychainService()
        let validUUID = UUID()
        let tokenData = validUUID.uuidString.data(using: .utf8)!
        
        // When
        let save = keychainService.save(data: tokenData)
        let loadedToken = keychainService.getToken()!
        
        // Then
        XCTAssertTrue(save)
        XCTAssertEqual(loadedToken, validUUID)
        
        // Clean up
        keychainService.delete(key: "authKey")
    }
    
    func testGetToken_realService_withOtherKey() {
        // Given
        let keychainService = KeychainService()
        let validKey = "validKey"
        let validUUID = UUID()
        let tokenData = validUUID.uuidString.data(using: .utf8)!
        
        // When
        let save = keychainService.save(key: validKey, data: tokenData)
        let loadedToken = keychainService.getToken(key: validKey)!
        let defaultToken = keychainService.getToken()
        
        // Then
        XCTAssertTrue(save)
        XCTAssertNil(defaultToken)
        XCTAssertEqual(loadedToken, validUUID)
        
        // Clean up
        keychainService.delete(key: validKey)
    }
}
