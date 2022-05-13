//
//  ArticleProvider.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import Foundation

enum ArticleProviderError: Error {
    case responseToStructError
}

struct ArticleProvider {
    private static let httpClient = HttpClient(baseUrl: Config.BaseUrl)
    
    static func getArticles() async throws -> [Article] {
        do {
            let response: Entry<[Article]> = try await httpClient.getJson(addtionalUrl: "/items/article?sort=-id&fields=id, title, createdDate")
            
            return response.data
        } catch {
            throw ArticleProviderError.responseToStructError
        }
    }
    
    static func getArticle(id: Int) async throws -> Article {
        do {
            let response: Article = try await httpClient.getJson(addtionalUrl: "/item/article/\(id)")
            
            return response
        } catch {
            throw ArticleProviderError.responseToStructError
        }
    }
}
