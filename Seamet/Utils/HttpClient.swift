//
//  HttpClient.swift
//  Seamet
//
//  Created by Jimmy on 5/19/22.
//

import Foundation

enum HttpClientError: Error {
    case invlidServerResponse(statusCode: Int)
    case invlidResponseGuaranteed
    case invlidUrl
    case failedToFetchData
    case failedToConvertData
    case failedToDecode
}


struct HttpClient {
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    private func sendRequest(addtionalUrl: String? = nil, method: String, headers: Dictionary<String, String>? = nil, body: Data? = nil) async throws -> Data {
        var url = self.url
        
        if let addtionalUrl = addtionalUrl {
            guard let newUrlInString = url.appendingPathComponent(addtionalUrl).absoluteString.removingPercentEncoding else {
                throw HttpClientError.invlidUrl
            }
            
            url = URL(string: newUrlInString) ?? self.url
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if method != "GET" {
            if let body = body {
                request.httpBody = body
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, let status = response.status else {
            throw HttpClientError.invlidResponseGuaranteed
        }
        
        print(response.statusCode)
        
        if status.responseType != .success {
            throw HttpClientError.invlidServerResponse(statusCode: response.statusCode)
        }
        
        return data
    }
    
    func getString(addtionalUrl: String? = nil, headers: Dictionary<String, String>? = nil) async throws -> String {
        guard let data = try? await sendRequest(addtionalUrl: addtionalUrl, method: "GET") else {
            throw HttpClientError.failedToFetchData
        }
                
        guard let dataInString = String(data: data, encoding: .utf8) else {
            throw HttpClientError.failedToConvertData
        }
        
        return dataInString
    }
    
    func getJson<TJson: Codable>(addtionalUrl: String? = nil, headers: Dictionary<String, String>? = nil) async throws -> TJson {
        guard let data = try? await sendRequest(addtionalUrl: addtionalUrl, method: "GET") else {
            throw HttpClientError.failedToFetchData
        }
        
        guard let decoded = try? JSONDecoder().decode(TJson.self, from: data) else {
            throw HttpClientError.failedToDecode
        }
        
        return decoded
    }
}
