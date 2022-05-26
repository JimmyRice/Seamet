//
//  Article.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import Foundation

struct Article: Codable, Hashable {
    let id: Int
    let title, createdDate: String
    let tags: [String]?
    let content: String?
    let author: Int?
    let slug: String?
    let category: Int?
    
    static private let articleHttpClient = HttpClient(url: URL(string: "\(Config.baseUrl)/items/article/")!)
    
    static func getArticles() async throws -> [Article] {
        let response: DataEntry<[Article]> = try await articleHttpClient.getJson(addtionalUrl: "?sort=-id&fields=id,title,createdDate")
        
        return response.data
    }
    
    static func getRecentArticle() async throws -> Article {
        let response: DataEntry<[Article]> = try await articleHttpClient.getJson(addtionalUrl: "?sort=-id&fields=id,title,createdDate&limit=1")
        
        return response.data[0]
    }
    
    static func getArticle(for articleId: Int) async throws -> Article {
        let response: DataEntry<Article> = try await articleHttpClient.getJson(addtionalUrl: "\(articleId)")
        
        return response.data
    }
}
