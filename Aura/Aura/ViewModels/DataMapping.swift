//
//  JSONEncoding.swift
//  Aura
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation

struct DataMapping {
    static func getStringFrom(_ data: Data) -> String? {
        guard let stringResponse = String(data: data, encoding: .utf8) else {
            return nil
        }
        return stringResponse
    }
}
