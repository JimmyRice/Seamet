//
//  ArticleListView.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import SwiftUI

struct ArticleListView: View {
    @State var articles: [Article] = []
    @State private var isLoading: Bool = true
    @State private var isFailed: Bool = false
    @State private var searchKeyword: String = ""
    
    var body: some View {
        NavigationView {
            if !isLoading {
                VStack {
                    if !isFailed {
                        if !articles.isEmpty {
                            List(articles, id: \.self) {article in
                                NavigationLink {
                                    ArticleDetailView(articleId: article.id)
                                } label: {
                                    ArticleListCell(title: article.title, dateTime: DatetimeUtil.ISO8601ToString(dateTime: article.createdDate))
                                }
                            }
                            .refreshable(action: fetchData)
                        } else {
                            Text(NSLocalizedString("ArticleListViewArticleIsEmpty", comment: ""))
                        }
                    } else {
                        Text(NSLocalizedString("ArticleListViewFailedToFetchArticle", comment: ""))
                    }
                }
                .navigationTitle(NSLocalizedString("ArticleListViewNavigationTitle", comment: ""))
            } else {
                ProgressView(NSLocalizedString("Loading", comment: ""))
                    .onAppear(perform: fetchData)
            }
        }
    }
    
    @Sendable func fetchData() {
        Task {
            guard let articles = try? await Article.getArticles() else {
                self.isFailed = true
                self.isLoading = false
                
                return
            }
            
            self.articles = articles
            self.isLoading = false
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static let articles = [Article(id: 1, title: "1", createdDate: "2022-04-21T12:16:00", tags: ["Only for test"], content: "", author: 1, slug: "", category: 1),
        Article(id: 2, title: "2", createdDate: "2022-04-21T12:16:00", tags: ["Only for test"], content: "", author: 1, slug: "", category: 1),
        Article(id: 3, title: "3", createdDate: "2022-04-21T12:16:00", tags: ["Only for test"], content: "", author: 1, slug: "", category: 1)]
    
    static var previews: some View {
        ArticleListView(articles: articles)
    }
}
