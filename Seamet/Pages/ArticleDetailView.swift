//
//  ArticleDetailView.swift
//  Seamet
//
//  Created by Jimmy on 5/13/22.
//

import SwiftUI

struct ArticleDetailView: View {
    var articleId: Int = 9
    @State private var article: Article = Article(id: 1, title: "我这是在干嘛", createdDate: "2022-04-21T12:16:00", tags: ["文章"], content: "呀，我这是在干嘛呀\n", author: 1, slug: "what-the-fuck-am-i-doing", category: 3)
    @State private var isLoading: Bool = true
    @State private var isFailed: Bool = false
    
    var body: some View {
        ScrollView {
            if !isLoading {
                if !isFailed {
                    VStack(alignment: .leading, spacing: 20) {
                        ArticleDetailHeader(articleTitle: article.title, articleCreatedDate: article.createdDate, articleTags: article.tags!)
                        ArticleDetailBody(articleContent: article.content!)
                            .padding(.top, 0)
                    }
                } else {
                    Text(NSLocalizedString("ArticleDetailViewFailedToFetchArticle", comment: ""))
                }
            } else {
                ProgressView()
                    .onAppear(perform: fetchData)
            }
        }
        .padding(.vertical, 0)
        .padding(.leading, 10)
        .padding(.top, 0)
    }
    
    func fetchData() {
        Task {
            guard let article = try? await Article.getArticle(for: articleId) else {
                self.isFailed = true
                self.isLoading = false
                
                return
            }
            
            self.article = article
            self.isLoading = false
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static private let articleId = 9
    
    static var previews: some View {
        ArticleDetailView(articleId: 9)
    }
}
