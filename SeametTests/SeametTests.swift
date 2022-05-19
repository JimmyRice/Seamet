//
//  SeametTests.swift
//  SeametTests
//
//  Created by Jimmy on 5/14/22.
//

import XCTest
@testable import Seamet

class ProviderTests: XCTestCase {
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testArticleProvider() async throws {
        do {
            let articles = try await ArticleProvider.getArticles()
            
            XCTAssertGreaterThan(articles.count, 1)
        } catch let error {
            print(error)
        }
    }
    
    func testRecentArticleProvider() async throws {
        do {
            let recentArticle = try await ArticleProvider.getRecentArticle()
                        
            XCTAssertNotNil(recentArticle)
            XCTAssertNotNil(recentArticle.title)
        } catch let error {
            print(error)
            
            throw error
        }
    }
}

class UtilTest: XCTestCase {
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testI8601ToString() throws {
        let dateInString = "2022-03-20T11:46:00"
        let convertString = DatetimeUtil.ISO8601ToString(dateTime: dateInString)
        
        XCTAssertEqual(convertString, "2022-03-20")
    }
    
    func testArticleTagsConvert() throws {
        let tags = ["Arknights", "Games"]
        let tagsInString = ArticleTagsUtil.articleTagsToString(tags: tags)
        
        XCTAssertEqual(tagsInString, "Arknights / Games")
    }
}

class HttpClientTest: XCTestCase {
    struct HttpBin: Codable {
        let origin: String
        let url: String
    }
    
    struct Character: Codable {
        let name: String
        let gender: String
    }
    
    private let httpClient = HttpClient(baseUrl: "https://httpbin.org")
    
    func testGetString() async throws {
        do {
            let response = try await httpClient.getString(addtionalUrl: "/get")
            
            print(response)
            
            XCTAssertNotNil(response)
        } catch let error {
            throw error
        }
    }
    
    func testGetJson() async throws {
        do {
            let response: HttpBin = try await httpClient.getJson(addtionalUrl: "/get")
            
            print(response)
            
            XCTAssertNotNil(response)
        } catch let error {
            print(error)
            
            throw error
        }
    }
    
    func testPostGetString() async throws {
        do {
            let character = Character(name: "yuta", gender: "Male")
            let headers = ["Content-Type": "application/json"]
            let encodedCharacter = try JSONEncoder().encode(character)
            
            let response = try await httpClient.postGetString(addtionalUrl: "/post", headers: headers, dataToPost: encodedCharacter)
            
            print(response)
            
            XCTAssertNotNil(response)
        } catch let error {
            print(error)
            
            throw error
        }
    }
    
    func testPostGetJson() async throws {
        do {
            let character = Character(name: "Yuta", gender: "Male")
            let headers = ["Content-Type": "application/json"]
            let encodedCharacter = try JSONEncoder().encode(character)
            
            let response: HttpBin = try await httpClient.postGetJson(addtionalUrl: "/post", headers: headers, dataToPost: encodedCharacter)
            
            print(response)
            
            XCTAssertNotNil(response)
        } catch let error {
            print(error)
            
            throw error
        }
    }

}
