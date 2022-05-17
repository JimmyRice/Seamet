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
            
            XCTAssertTrue(articles is [Article])
            XCTAssertGreaterThan(articles.count, 1)
        } catch let error {
            print(error)
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
