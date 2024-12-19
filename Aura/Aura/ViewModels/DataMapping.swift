//
//  JSONEncoding.swift
//  Aura
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation

struct DataMapping {
    // retourn la data sous forme de string si elle et bien codé en utf8
    static func getStringFrom(_ data: Data) -> String? {
        guard let stringResponse = String(data: data, encoding: .utf8) else {
            return nil
        }
        return stringResponse
    }
}
