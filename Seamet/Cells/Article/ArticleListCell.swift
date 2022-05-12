//
//  ArticleListCell.swift
//  Seamet
//
//  Created by Jimmy on 5/12/22.
//

import SwiftUI

struct ArticleListCell: View {
    var title: String
    var dateTime: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text(dateTime)
                .foregroundColor(.gray)
        }
    }
}

struct ArticleListCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListCell(title: "Title", dateTime: DatetimeUtil.ISO8601ToString(dateTime: "2022-03-20T11:46:00"))
    }
}
