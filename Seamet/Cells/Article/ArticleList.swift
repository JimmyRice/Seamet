//
//  ArticleList.swift
//  Seamet
//
//  Created by Jimmy on 5/13/22.
//

import SwiftUI

struct ArticleList: View {
    var articles: [Article] = []
    
    var body: some View {
        VStack {
            List(articles, id: \.self) {article in
                ArticleListCell(title: article.title, dateTime: DatetimeUtil.ISO8601ToString(dateTime: article.createdDate))
            }
        }
    }
}

struct ArticleList_Previews: PreviewProvider {
    static let articles = [Article(id: 1, title: "1", createdDate: "2022-04-21T12:16:00", tags: ["Only for test"], content: "", author: 1, slug: "", category: 1),
        Article(id: 2, title: "2", createdDate: "2022-04-21T12:16:00", tags: ["Only for test"], content: "", author: 1, slug: "", category: 1),
        Article(id: 3, title: "3", createdDate: "2022-04-21T12:16:00", tags: ["Only for test"], content: "", author: 1, slug: "", category: 1)]

    static var previews: some View {
        ArticleList(articles: articles)
    }
}
