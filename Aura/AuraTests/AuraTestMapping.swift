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
}
