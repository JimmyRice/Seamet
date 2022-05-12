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
    
    var body: some View {
        NavigationView {
            if !isLoading {
                VStack {
                    if !articles.isEmpty {
                        List(articles, id: \.self) {article in
                            NavigationLink {
                                Text("Working in progress...")
                            } label: {
                                ArticleListCell(title: article.title, dateTime: DatetimeUtil.ISO8601ToString(dateTime: article.createdDate))
                            }
                        }
                    } else {
                        Text("文章似乎为空哦...找点别的看吧")
                    }
                }
                .navigationTitle("Seamain 的小窝")
            } else {
                ProgressView("加载中...")
                    .onAppear {
                        onAppear()
                    }
            }
        }
    }
    
    func onAppear() {
        Task {
            guard let articles = try? await ArticleProvider.getArticles() else {
                fatalError()
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
