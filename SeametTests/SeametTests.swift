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
    
    func testGetAllArticlesProvider() async throws {
        let articles = try await Article.getArticles()
        
        print(articles)
        
        XCTAssertNotNil(articles)
    }
    
    func testGetRecentArticleProvider() async throws {
        let recentArticle = try await Article.getRecentArticle()
        
        print(recentArticle)
                    
        XCTAssertNotNil(recentArticle)
    }
    
    func testGetArticleProvider() async throws {
        let article = try await Article.getArticle(for: 1)
        
        print(article)
        
        XCTAssertNotNil(article)
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
                
        XCTAssertNotNil(response)
    }
    
    func testGetJson() async throws {
        let response: DataEntry<[Article]> = try await httpClient.getJson(addtionalUrl: "/items/article")
        
        XCTAssertNotNil(response.data)
        XCTAssertGreaterThan(response.data.count, 1)
    }
}
