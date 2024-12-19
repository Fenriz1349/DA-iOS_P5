//
//  AppConfig.swift
//  Aura
//
//  Created by Julien Cotte on 05/12/2024.
//

import Foundation

struct AppConfig {

    let baseURLString: String = "http://127.0.0.1:8080"
    var authURLString: String {
        return baseURLString + "/auth"
    }
    
    var baseUrl: URL {
         URL(string: baseURLString)!
    }
    
    var authURL: URL {
        URL(string: authURLString)!
    }
}
