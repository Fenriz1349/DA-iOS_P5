//
//  MockURLProtocol.swift
//  AuraTests
//
//  Created by Julien Cotte on 06/12/2024.
//

import Foundation

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

class MockURLSession {
    static var shared: URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }
}
