//
//  AuraTestMapping.swift
//  AuraTests
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation

import XCTest
@testable import Aura

class AuraTestsMapping: XCTestCase {
    func testgetStringFrom_Sucess() {
        // Given
        let mockData = Data("mock data".utf8)
        
        // When
        let mockString = DataMapping.getStringFrom(mockData)
        
        // Then
        XCTAssertEqual(mockString, "mock data")
    }
    
    func testGetStringFrom_returnNil() {
        // Given
        let mockData = Data([0xD8, 0x00])
        
        // When
        let mockString = DataMapping.getStringFrom(mockData)
        
        // Then
        XCTAssertNil(mockString)
    }
    
    func testJSONAuthEncoder() {
        // Given
        let username = "test@test.com"
        let password = "password"
        let encoder = JSONEncoder()
        let expectedJSON: [String: String] = [
                "username": "test@test.com",
                "password": "password"
            ]
        
        // When
        let jsonData = try! encoder.encode(expectedJSON)
        let result = JSONMapping.jsonAuthEncoder(username: username, password: password)
        
        // Then
        XCTAssertEqual(result, jsonData)
    }
    
    func testJSONAuthDecoder_WithValidToken_ReturnsUUID() {
           // Given
           let validUUIDString = "123E4567-E89B-12D3-A456-426614174000"
           let json = """
           {
               "token": "\(validUUIDString)"
           }
           """
           let data = Data(json.utf8)
           
           // When
        do {
            let result = try JSONMapping.jsonAuthDecoder(data)
            // Then
            XCTAssertEqual(result.uuidString, validUUIDString)
        } catch {
            
        }
       }
    
    func testJSONAuthDecoder_WithoutTokenKey_ReturnError() {
        // Given
        let json = """
            {
                "key": "value"
            }
            """
        let data = Data(json.utf8)
        
        // When
        do {
            let _ = try JSONMapping.jsonAuthDecoder(data)
        } catch let error as URLError {
            // Then/
            XCTAssertEqual(error.code, URLError.Code.cannotDecodeContentData)
        } catch {
            
        }
    }
    
    func testJSONAuthDecoder_WithInvalidTokenValue_ReturnError() {
        // Given
        let json = """
            {
                "token": "invalid-uuid"
            }
            """
        let data = Data(json.utf8)
        
        // When
        do {
            let _ = try JSONMapping.jsonAuthDecoder(data)
        } catch let error as URLError {
            // Then/
            XCTAssertEqual(error.code, URLError.Code.cannotDecodeContentData)
        } catch {
            
        }
    }
    
    func testJSONAuthDecoder_WithMalformedJSON_ReturnsNil() {
        // Given
        let json = """
           {
               "token": "123e4567-e89b-12d3-a456-426614174000"
           """
        // JSON mal formé, manque une accolade fermante
        let data = Data(json.utf8)
        
        // Then
        do {
            let _ = try JSONMapping.jsonAuthDecoder(data)
        } catch let error as URLError {
            // Then/
            XCTAssertEqual(error.code, URLError.Code.cannotDecodeContentData)
        } catch {
            
        }
    }
}
