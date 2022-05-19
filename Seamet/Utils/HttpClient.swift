//
//  HttpClient.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import Foundation

enum HttpClientError: Error {
    case invalidUrl
    case createHttpRequestError
    case dataCannotConvertToString
    case internetOrRequestError
    case dataConnotConvertToJson
    case stringConvertToDataError
    case dataConvertToJsonError
    case requestNotOk
}

struct HttpClient {
    private var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getString(addtionalUrl: String = "/", headers: Dictionary<String, String>? = [:]) async throws -> String {
        
        guard let url = URL(string: baseUrl + addtionalUrl) else {
            throw HttpClientError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw HttpClientError.requestNotOk
            }
            
            guard let dataInString = String(data: data, encoding: .utf8) else {
                throw HttpClientError.dataCannotConvertToString
            }
            
            return dataInString
        } catch {
            throw HttpClientError.internetOrRequestError
        }
    }
    
    func getJson<TJson: Codable>(addtionalUrl: String = "/", headers: Dictionary<String, String>? = [:]) async throws -> TJson {
        do {
            let dataInString = try await getString(addtionalUrl: addtionalUrl, headers: headers)
            guard let data = dataInString.data(using: .utf8) else {
                throw HttpClientError.stringConvertToDataError
            }
            
            guard let Json = try? JSONDecoder().decode(TJson.self, from: data) else {
                throw HttpClientError.dataConvertToJsonError
            }
            
            return Json;
        } catch {
            throw HttpClientError.internetOrRequestError
        }
    }
}
