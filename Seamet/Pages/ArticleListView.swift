//
//  ArticleListView.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import SwiftUI

struct ArticleListView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static let articles = [Article(id: 1, title: "1", createdDate: "2022-04-21T12:16:00", tags: ["Only for test"], content: "", author: 1, slug: "", category: 1),
        Article(id: 2, title: "2", createdDate: "2022-04-21T12:16:00", tags: ["Only for test"], content: "", author: 1, slug: "", category: 1),
        Article(id: 3, title: "3", createdDate: "2022-04-21T12:16:00", tags: ["Only for test"], content: "", author: 1, slug: "", category: 1)]
    
    static var previews: some View {
        ArticleListView()
    }
}
