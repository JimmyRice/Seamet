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
        let articles = try await ArticleProvider.getArticles()
        
        print(articles)
        
        XCTAssertGreaterThan(articles.count, 1)
    }
    
    func testRecentArticleProvider() async throws {
        let recentArticle = try await ArticleProvider.getRecentArticle()
        
        print(recentArticle)
                    
        XCTAssertNotNil(recentArticle)
        XCTAssertNotNil(recentArticle.title)
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
    private var httpClient: HttpClient!
    
    override func setUpWithError() throws {
        guard let url = URL(string: Config.baseUrl) else {
            return
        }
        
        httpClient = HttpClient(url: url)
    }
    
    override func tearDownWithError() throws {
        httpClient = nil
    }
    
    func testGetString() async throws {
        let response = try await httpClient.getString(addtionalUrl: "/items/article")
        
        print(response)
        
        XCTAssertNotNil(response)
    }
    
    func testGetJson() async throws {
        let response: DataEntry<[Article]> = try await httpClient.getJson(addtionalUrl: "/items/article")
        
        print(response.data)
        
        XCTAssertNotNil(response.data)
        XCTAssertGreaterThan(response.data.count, 1)
    }
}

class OldHttpClientTest: XCTestCase {
    struct HttpBin: Codable {
        let origin: String
        let url: String
    }
    
    struct Character: Codable {
        let name: String
        let gender: String
    }
    
    private let httpClient = OldHttpClient(baseUrl: "https://httpbin.org")
    
    func testGetString() async throws {
        let response = try await httpClient.getString(addtionalUrl: "/get")
        
        print(response)
        
        XCTAssertNotNil(response)
    }
    
    func testGetJson() async throws {
        let response: HttpBin = try await httpClient.getJson(addtionalUrl: "/get")
        
        print(response)
        
        XCTAssertNotNil(response)
    }
    
    func testPostGetString() async throws {
        let character = Character(name: "yuta", gender: "Male")
        let headers = ["Content-Type": "application/json"]
        let encodedCharacter = try JSONEncoder().encode(character)
        
        let response = try await httpClient.postGetString(addtionalUrl: "/post", headers: headers, dataToPost: encodedCharacter)
        
        print(response)
        
        XCTAssertNotNil(response)
    }
    
    func testPostGetJson() async throws {
        let character = Character(name: "Yuta", gender: "Male")
        let headers = ["Content-Type": "application/json"]
        let encodedCharacter = try JSONEncoder().encode(character)
        
        let response: HttpBin = try await httpClient.postGetJson(addtionalUrl: "/post", headers: headers, dataToPost: encodedCharacter)
        
        print(response)
        
        XCTAssertNotNil(response)
    }
}
