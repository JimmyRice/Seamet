//
//  ArticleDetailHeader.swift
//  Seamet
//
//  Created by Jimmy on 5/13/22.
//

import SwiftUI

struct ArticleDetailHeader: View {
    var articleTitle: String = ""
    var articleCreatedDate: String = ""
    var articleTags: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(articleTitle)
                .font(.title)
                .fontWeight(.heavy)
            
            HStack {
                Text(articleCreatedDate)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                Text("|")
                    .fontWeight(.bold)
                Text(ArticleTagsUtil.articleTagsToString(tags: articleTags))
                    .fontWeight(.light)
            }
        }
    }
}

struct ArticleDetailHeader_Previews: PreviewProvider {
    static private var articleTitle: String = "Moon soil used to grow plants for first time in breakthrough test"
    static private var articleCreatedDate: String = "2022/3/10"
    static private var articleTags: [String] = ["Test", "Demo"]
    
    static var previews: some View {
        ArticleDetailHeader(articleTitle: articleTitle, articleCreatedDate: articleCreatedDate, articleTags: articleTags)
    }
}
