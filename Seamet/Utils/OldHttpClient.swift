//
//  HttpClient.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

/**
 This HttpClient will be considered for refactoring soon and other HTTP methods will be added after the refactoring
 
 Until the refactoring is complete: DO NOT TOUCH
 */

import Foundation

enum OldHttpClientError: Error {
    case invalidUrl
    case createHttpRequestError
    case dataToStringError
    case internetOrRequestError
    case dataConnotConvertToJson
    case stringToDataError
    case dataDecodeError
    case invlidServerResponse(errorStatusCode: Int)
    case invlidResponseGuaranteed
}

struct OldHttpClient {
    private var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getString(addtionalUrl: String = "/", headers: Dictionary<String, String>? = [:]) async throws -> String {
        
        guard let url = URL(string: baseUrl + addtionalUrl) else {
            throw OldHttpClientError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw OldHttpClientError.invlidResponseGuaranteed
        }
        
        if response.statusCode != 200 {
            throw OldHttpClientError.invlidServerResponse(errorStatusCode: response.statusCode)
        }
        
        guard let dataInString = String(data: data, encoding: .utf8) else {
            throw OldHttpClientError.dataToStringError
        }
        
        return dataInString
    }
    
    func getJson<TJson: Codable>(addtionalUrl: String = "/", headers: Dictionary<String, String>? = [:]) async throws -> TJson {
        let dataInString = try await getString(addtionalUrl: addtionalUrl, headers: headers)
        guard let data = dataInString.data(using: .utf8) else {
            throw OldHttpClientError.stringToDataError
        }
        
        guard let json = try? JSONDecoder().decode(TJson.self, from: data) else {
            throw OldHttpClientError.dataDecodeError
        }
        
        return json;
    }
    
    func postGetString(addtionalUrl: String = "/", headers: Dictionary<String, String>? = [:], dataToPost: Data) async throws -> String {
        guard let url = URL(string: baseUrl + addtionalUrl) else {
            throw OldHttpClientError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = dataToPost
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw OldHttpClientError.invlidResponseGuaranteed
        }
                    
        if response.statusCode != 200 && response.statusCode != 201 {
            throw OldHttpClientError.invlidServerResponse(errorStatusCode: response.statusCode)
        }
        
        guard let dataInString = String(data: data, encoding: .utf8) else {
            throw OldHttpClientError.dataToStringError
        }
        
        return dataInString
    }
    
    func postGetJson<TJson: Codable>(addtionalUrl: String = "/", headers: Dictionary<String, String>? = [:], dataToPost: Data) async throws -> TJson {
        let dataInString = try await postGetString(addtionalUrl: addtionalUrl, headers: headers, dataToPost: dataToPost)
        
        guard let data = dataInString.data(using: .utf8) else {
            throw OldHttpClientError.stringToDataError
        }
        
        guard let json = try? JSONDecoder().decode(TJson.self, from: data) else {
            throw OldHttpClientError.dataDecodeError
        }
        
        return json;
    }
}
