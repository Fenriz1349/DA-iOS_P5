//
//  MockURLProtocol.swift
//  AuraTests
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation
@testable import Aura
// MockURLProtocol intercepte les requêtes effetué et permet de simuler des réponses
class MockURLProtocol: URLProtocol {
    static var mockResponseData: Data?
    static var mockResponse: URLResponse?
    static var mockError: Error?
    
    // Cette méthode interceptera la requête et renverra la réponse simulée.
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Renvoie la réponse simulée ou une erreur
        if let error = MockURLProtocol.mockError {
            client?.urlProtocol(self, didFailWithError: error)
        } else if let response = MockURLProtocol.mockResponse, let data = MockURLProtocol.mockResponseData {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {
        // Aucune opération supplémentaire n'est nécessaire ici.
    }
}

// Permet de rediriger les requetes HTTP vers MockURLProtocol
class MockURLSession {
    static var shared: URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }
}

// Permet de 
class MockHTTPClient: HTTPClient {
    
    var mockData: Data?
    var mockError: Error?

    func performRequest(from url: URL, with method: HTTPMethod) async throws -> Data {
        if let error = mockError {
            throw error
        }
        return mockData ?? Data()
    }
    func performAuthRequest(username: String, password: String, url: URL) async throws -> Data {
        if let error = mockError {
            throw error
        }
        return mockData ?? Data()
    }
}

class MockAuthenticationRepository: AuthenticationRepository {
    var tryGetResult: Bool = true
    var getTokenResult: UUID? = nil

    override func tryGet(url: URL = AppConfig().baseUrl) async -> Bool {
        return tryGetResult
    }

    override func getTokenFrom(username: Email, password: String) async -> UUID? {
        return getTokenResult
    }
}
