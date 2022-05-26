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
    @State private var isError: Bool = false
    @State private var searchKeyword: String = ""
    
    var body: some View {
        NavigationView {
            if !isLoading {
                VStack {
                    if !isError {
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
                            Text("文章似乎为空哦...找点别的看吧")
                        }
                    } else {
                        Text("无法获取到文章，重启 App **或许**会有效")
                    }
                }
                .navigationTitle(Config.articleListViewTitle)
            } else {
                ProgressView("加载中...")
                    .onAppear(perform: fetchData)
            }
        }
    }
    
    @Sendable func fetchData() {
        Task {
            guard let articles = try? await Article.getArticles() else {
                self.isError = true
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
