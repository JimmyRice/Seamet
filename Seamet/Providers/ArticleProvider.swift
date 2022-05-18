//
//  ArticleProvider.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import Foundation

struct ArticleProvider {
    private static let httpClient = HttpClient(baseUrl: Config.baseUrl)
    
    static func getArticles() async throws -> [Article] {
        do {
            let response: DataEntry<[Article]> = try await httpClient.getJson(addtionalUrl: "/items/article?sort=-id&fields=id,title,createdDate")
            
            return response.data
        } catch let error {
            throw error
        }
    }
    
    static func getRecentArticle() async throws -> Article {
        do {
            let response: DataEntry<[Article]> = try await httpClient.getJson(addtionalUrl: "/items/article?sort=-id&fields=id,title,createdDate&limit=1")
            
            return response.data[0]
        } catch let error {
            print(error)
            
            throw error
        }
    }
    
    static func getArticle(id: Int) async throws -> Article {
        do {
            let response: DataEntry<Article> = try await httpClient.getJson(addtionalUrl: "/items/article/\(id)")
            
            return response.data
        } catch let error {
            throw error
        }
    }
}
