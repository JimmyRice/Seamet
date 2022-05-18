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
